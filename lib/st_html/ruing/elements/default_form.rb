# 
#     StHtml
# 
#   Il presente file fa parte del progetto StHtml che viene distribuito 
#   secondo le clausole della licenza MIT. Nella directory base(root) del 
#   progetto è presente una copia della licenza.
# 
#   For non italian speakers, please be able to translate into your native 
#   language the license terms expressed by the previous statements. The only
#   valid license is the one expressed in those statements.
# 
#   Copyright Tomaso Tosolini/Stefano Salvador - 2007-2074
#   Please contact at gmail: tomaso.tosolini
# 

require 'st'
require 'st/html'
require 'st/html/form3'
require 'st/html/form3/elements'

require 'st/html/form3/elements/default_group'
require 'st/html/form3/elements/hidden'

require 'st/html/support/util'

require 'st/html/form3/renderers/form_renderer'
require 'st/html/form3/serializers/form_serializer'

require 'st/html/form3/renderers/form_control_group_form_name_renderer'
require 'st/html/form3/renderers/form_control_group_rest_method_renderer'

require 'st/html/form3/abstract_button'


require 'st/html/form3/exceptions'


module St
module Html
module Form3
module Elements

    class DefaultForm < DefaultGroup
    
    # TODO 
    # Bisogna aggiungere il supporto per il layout manager a livello complessivo di form, in questo momento 
    # e' abilitato solo per quanto riguarda gli items.
    
    
    
        attr :control_group, true
    
        attr :buttons, true
        attr :action_button, true
    
    
        def initialize(n, *formoptions)
            fo = St::Html::Support::Util.extract_variable_options( formoptions )
            super(n, { 
    
                :verb => :post,  # || :get || :put
                :mode => :normal,   # || :ajax
                :rest => true,   # || false
    
                :controller => nil,  
                :multipart => false, # utilizzabile solo nel caso :mode => :normal
    
                #:validator => St::Html::Form3::Validators::FormValidator.new( fo[:validator_option] ),
                :renderer => St::Html::Form3::Renderers::FormRenderer.new( fo[:renderer_option] ),
                :serializer => St::Html::Form3::Serializers::FormSerializer.new( fo[:serializer_option] )
            }.merge( fo.merge( { :action => :form_action_port } ) ) )
                # se fo contiene specifiche esplicite di validatore renderer o serializer queste prendono il sopravvento
                # qui queste ultime cose sono state rimosse dal group(vedi inizializzatore...)
    
    
            if self.options[:mode].eql?(:normal)
                if self.options[:rest]
                    raise( Exception, "You cannot use normal mode, rest and get" ) if self.options[:verb].eql?(:get)
                else
                    raise( Exception, "You cannot use normal mode, unrest and put" ) if self.options[:verb].eql?(:put)
                end
                
            else
                if self.options[:rest]
                    raise( Exception, "You cannot use ajax mode, rest and get" ) if self.options[:verb].eql?(:get)
                else
                    raise( Exception, "You cannot use ajax mode, unrest and get" ) if self.options[:verb].eql?(:get)
                    raise( Exception, "You cannot use ajax mode, unrest and put" ) if self.options[:verb].eql?(:put)
                end
            end
            
    
    
            @control_group = St::Html::Form3::Elements::DefaultGroup.new("#{self.name}_control_group")
    
            # the form name hidden is something special it is usedon post to determina the repond call...
            form_name = @control_group.add( St::Html::Form3::Elements::Hidden.new("form_name", { 
                :renderer => St::Html::Form3::Renderers::FormControlGroupFormNameRenderer.new( :ui_view_factory => St::Html::UiViews::Factory ) }) )
            form_name.value= @name
    
            if self.options[:mode].eql?(:normal) && self.options[:rest]
                rest_method = @control_group.add( St::Html::Form3::Elements::Hidden.new("rest_method", { 
                    :renderer => St::Html::Form3::Renderers::FormControlGroupRestMethodRenderer.new( :ui_view_factory => St::Html::UiViews::Factory ) }) )
            
            end
    
    
            @action_button = @control_group.add( St::Html::Form3::Elements::Hidden.new("action_button" ) )
            @action_button.value= ""
    
            @buttons = @control_group.add( St::Html::Form3::Elements::DefaultGroup.new("buttons" ) )
            @buttons.extend( FormButtonsMethods )
                #
                #
                # buttons receive automatically the repaint methods so one can call 
                # this method always
                #
        end
    
        def add( object )
            if object.is_a?( St::Html::Form3::AbstractButton )
                @buttons.add(object)
                object.target_action_button_carrier= { :form_name => @name, :hidden_name => @action_button.get_input_id }
            else
                super(object)
            end
    
            return object;
        end
    
    
        def parent
            return nil
        end
    
    
    
        # since forms are "top level" my be uses especially in clones_groups to get thier sub elemnts by path
        def get_by_path( path )
            path = path.split(St::Html::Form3::PATH_SEP)
            # path[0] now is the form itself.
            path.shift
    
            c = self
            while path.size > 0 do
                #p path[0]
                c = c.items(path.shift)
                raise(St::Html::Form3::Exceptions::FormException, "Invalid path.") unless c
            end
            return c
        end
    
    
    
        private
    
            def parent=( x )
            end
            
            
            
            module FormButtonsMethods
                def repaint(page)
                    self.renderer.update(page, self, :editable => true)
                end
            end
    
    
    end

end
end
end
end









