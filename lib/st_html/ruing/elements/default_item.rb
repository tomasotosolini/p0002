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
#require 'st/html/form3/abstract_item'
#require 'st/html/form3/elements/copyable'
#
#require 'st/html/form3/renderers/item_renderer'
#require 'st/html/form3/serializers/item_serializer'

require 'st_html/ruing/abstract_item'
require 'st_html/ruing/elements/copyable'
require 'st_html/ruing/elements/renderers/default_item_renderer'


module StHtml
module Ruing
module Elements


class DefaultItem < StHtml::Ruing::AbstractItem

    include Copyable # This is to put items in Clones Container.

    attr :validators, true 
    attr :renderer, true 
    attr :editor, true 
    attr :serializer, true 
    attr :session, true 


    def initialize n, *item_options
        
        super

        @validators = self.options[:validators] || []
          #
          # By default no validator is set.

        @renderer = self.options[:renderer] \
                || StHtml::Ruing::Elements::Renderers::DefaultItemRenderer.new( \
                    self.options[:renderer_options] || {}  ) \
                unless @renderer
        
#        @serializer = self.options[:serializer] \
#                || StHtml::Ruing::Elements::Serializers::ItemSerializer.new( \
#                    self.options[:serializer_options] )
                    
        @editor = nil
        
        #
        # Give default options when nothing is passed. 
        #
        self.options[:render] = {} unless self.options[:render]
        self.options[:force][:render] = {} unless self.options[:force][:render]
        #
        # Serilization doesn't require default for now
        #
        
        #
        # Let's clean out options that are saved elsewhere.
        #
#        self.options.delete( :validators )

        self.options.delete :renderer 
        self.options.delete :renderer_options 

#        self.options.delete( :serializer )
#        self.options.delete( :serializer_options )

        @session = self.options[:session]

    end

    # Copy contructor
    #
    # Subclasses must call the method passing the block where the *correct* 
    # *type* is initialized, then here we can set the common data and at the end
    # when this method exits the subclass may proceed with more specific copying
    # activities.
    # 
    def copy
        
        rv = unless block_given? 
            DefaultItem.new nil, self.options
        else
            yield(self.options) || nil
        end

        unless rv.nil?
            rv.name= self.name
            rv.value = self.value
            rv.validators= @validators.map { |x| x.copy }
            rv.renderer= @renderer.copy
            rv.serializer= @serializer.copy
            rv.editor= @editor.copy
            rv.session = @session
        end

        rv
    end

    
    def render *render_options
        render_options = extract_va_options render_options
        renderer.render self, render_options
    end
    def render_ *render_options
        render_options = extract_va_options render_options
        renderer.render self, render_options.merge( { :editable => false } )
    end
end

end
end
end












