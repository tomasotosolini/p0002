###########################################################################
#    Copyright (C) 2007 by Tomaso Tosolini, Stefano Salvador
#    <tomaso.tosolini@cbm.fvg.it>
#    <stefano.salvador@cbm.fvg.it>
#
# Copyright: See COPYING file that comes with this distribution
#
###########################################################################

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

require 'st_html_license'

require 'st_html/ruing/abstract_item'
require 'st_html/ruing/elements/copyable'

require 'st_html/ruing/elements/renderers/default_item_renderer'


module StHtml
module Ruing
module Elements


class DefaultItem < StHtml::Ruing::AbstractItem

    include Copyable # This is to put items in Clones Container.

    attr( :validators, true )
    attr( :renderer, true )
    attr( :editor, true )
    attr( :serializer, true )
    attr( :session, true )


    def initialize(n, *itemoptions)
        
        super

        @validators = self.options[:validators] || []
          #
          # By default no validator is set.

        @renderer = self.options[:renderer] \
                || StHtml::Ruing::Elements::Renderers::DefaultItemRenderer.new( \
                    self.options[:renderer_options] || {}  )
        
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

        self.options.delete( :renderer )
        self.options.delete( :renderer_options )
        self.options.delete( :render )
        self.options[:force].delete( :render )

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
            DefaultItem.new(nil, self.options)
        else
            yield(self.options) || nil
        end

        unless rv.nil?
            rv.name= self.name
            rv.value = self.value
            rv.validators= @validators
            rv.renderer= @renderer
            rv.serializer= @serializer
            rv.editor= @editor
        end

        rv
    end

    
    def render *renderoptions
        renderoptions = extract_va_options renderoptions
        renderer.render self, renderoptions
    end
    def render_ *renderoptions
        renderoptions = extract_va_options renderoptions
        renderer.render self, renderoptions.merge( { :editable => false } )
    end
end

end
end
end












