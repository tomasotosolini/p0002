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

require 'st_html/ruing/abstract_container'
require 'st_html/ruing/copyable'
require 'st_html/ruing/elements/renderers/container_renderer'
require 'st_html/ruing/elements/serializers/container_serializer'
require 'st_html/ruing/elements/layout/vertical_layout'


module StHtml
module Ruing
module Elements

class DefaultContainer < StHtml::Ruing::AbstractContainer

    include StHtml::Ruing::Copyable 

    attr :validators, true 
    attr :renderer, true 
    attr :serializer, true 
    
    #
    # Will always be only a reference
    #
    attr :session, true

    def initialize n, *container_options

        co = extract_va_options container_options
        
        @validators = self.options[:validators] || []
          #
          # By default no validator is set.

        @renderer = co[:renderer] \
                || StHtml::Ruing::Elements::Renderers::ContainerRenderer.new( \
                  co[:renderer_options] || {}  )
                unless @renderer
        
        @serializer = co[:serializer] \
                 || StHtml::Ruing::Elements::Serializers::ContainerSerializer.new( \
                    co[:serializer_options] || {}  ) \
                 unless @serializer
        
        #
        # This sets validators, editor to nil, default rendering otions, 
        # default serialization options, session
        #
        super n, co

        self.session= self.options.delete :session
    end


    #
    # This method has an interface similar to the parent's one, but it supports 
    # layout management so it takes as input a single or a list of:
    # 
    # 1. an item x
    # 2. an hash: { :item => x, :layout_constraint => l }
    #
    def add *new_items
        
        # Items and positioning list, receiving always an Array
        #
        ip_list = extract_va_options new_items, false 
          
        # Input homogeneization
        #
        ip_list.map!{ |i| i.is_a?(Hash) ? i : { 
                :item => i, 
                :layout_constraint => nil 
            } }

        # Preparing input for super, and for method retval
        #
        new_items = ip_list.map{ |i| i[:item] }
        
        # We do as abstract container for contained items... 
        #
        super new_items
          
        # ... if have a layout manager the put elements into layout constraint
        #
        if @renderer && @renderer.layout_manager
            
            ip_list.each do |i| 
                @renderer.layout_manager.add i[:item].name, i[:layout_constraint]
            end
        end
        
        new_items
    end

    #
    # See add method comments
    #
    def remove name_or_index
        
        # Name_or_index and positioning list, receiving always an Array
        #
        nip_list = extract_va_options name_or_index, false 
          
        # Input homogeneization
        #
        nip_list.map!{ |ni| ni.is_a?(Hash) ? ni : { 
                :item => ni, 
                :layout_constraint => nil } }
        
        # Preparing input for super, and for method retval
        #
        name_or_index = nip_list.map{ |ni| ni[:item] }
           

        # If have a layout manager then remove layout constraint...
        #
        if @renderer && @renderer.layout_manager
            
            ip_list.each do |i| 
                @renderer.layout_manager.remove i[:layout_constraint]
            end
        end
        
        # ...and then we do as abstract container for contained items
        #
        super name_or_index
        
    end



    def copy
        
        rv = super { |options_|
            
            # Argument hash unchanged
            #
            options = options_.merge \
                        :renderer_options => @renderer.options, \
                        :serializer_options => @serializer.options
            
            options[:renderer_options].merge!( :layout_manager_options => \
                        @renderer.layout_manager.options  ) if @renderer \
                            && @renderer.layout_manager
             
            DefaultContainer.new self.name, options
        }
        
        if @renderer && @renderer.layout_manager
            #
            # If present we assume that clients are smart enough have correspondence
            # between items and layout constraints, i.e. make work fine the layout
            # mechanism. Now the constraints drive.
            #
            # NOTE: by default we use vertical layout so, no layout component is
            # present
            #
            @renderer.layout_manager.each do |constraint, name|
                # layout_constraint is unused
                rv.add self.items(name)
            end
        else
            #
            # Procees copying the sequence of the items
            #
            self.items.each do |i|

                begin

                    # This also sets up parental relations
                    #
                    rv.add i.copy

                rescue Exception => e
                    raise ruing_exception, \
                            "Item is no copyable."
                end
            end
        end
        
        rv
    end


    def session= x 

        @session = x

        @items.each do |i|
            i.session= @session
        end        

    end

end
    
end
end
end




















