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

#require 'st'
#require 'st/html'
#require 'st/html/form3'
#require 'st/html/form3/elements'
#
#require 'st/html/form3/abstract_group'
#require 'st/html/form3/elements/copyable'
#
#require 'st/html/form3/validators/group_validator'
#require 'st/html/form3/renderers/group_renderer'
#require 'st/html/form3/serializers/group_serializer'
#
#require 'st/html/form3/exceptions'

require 'st_html/ruing/abstract_group'

#require 'st_html/ruing/elements/copyable'

module StHtml
module Ruing
module Elements

    class DefaultGroup < StHtml::Ruing::AbstractGroup
    
        #include Copyable # so toy can put it into a clones group....
    
    
        attr( :validators, true )
        attr( :renderer, true )
        attr( :editor, true ) # l'editor si da a mano.
        attr( :serializer, true )
        attr( :layout_manager, true)
        attr( :session, true)
    
    
        def initialize(n, *groupoptions)
            super
    
            @validators = self.options[:validators] || [St::Html::Form3::Validators::GroupValidator.new( self.options[:validator_option] )]
            @renderer = self.options[:renderer] || St::Html::Form3::Renderers::GroupRenderer.new( self.options[:renderer_option] )
            @serializer = self.options[:serializer] || St::Html::Form3::Serializers::GroupSerializer.new( self.options[:serializer_option] )
            @layout_manager = self.options[:layout_manager] if self.options[:layout_manager]
    
            self.options[:render] = {} unless self.options[:render]
            self.options[:force][:render] = {} unless self.options[:force][:render]
    
    
                #let's clean out options that are saved elsewhere
            self.options.delete( :validators )
            self.options.delete( :validator_option )
    
            self.options.delete( :renderer )
            self.options.delete( :renderer_option )
    
            self.options.delete( :serializer )
            self.options.delete( :serializer_option )
    
            self.options.delete( :layout_manager ) 
    
        end
    
    
    
    
        def add(x, layout_constraint=nil)
            @layout_manager.addLayoutItem(layout_constraint, x) if @layout_manager
            return super(x)
        end
    
        def remove(x)
            @layout_manager.removeLayoutItem(layout_constraint, x) if @layout_manager
            return super(x)
        end
    
    
    
        def copy
            rv = DefaultGroup.new(nil, self.options)
            rv.name= self.name
            rv.value = self.value
            rv.validator= @validator
            rv.renderer= @renderer
            rv.layout_manager= @layout_manager
        
            self.items.each do |item|
                begin
                    rv.add( item.copy )
                rescue Exception => e
                    raise(St::Html::Form3::Exceptions::NotCopyableException, "Item is no copyable.")
                end
            end
    
            return rv
        end
    
    
        def session=( x )
    
            @session = x
    
            @items.each do |i|
                i.session= @session
            end        
    
        end
        
    end
    
end
end
end
end



















