
#require 'st'
#require 'st/html'
#require 'st/html/form3'
#require 'st/html/form3/renderers'
#
#require 'st/html/ruing/render/abstract_renderer'
#
#require 'st/html/ui_views/factory'
#
#require 'st/html/form3/exceptions'

require 'st_html_license'

require 'st_html/ruing/ruing'
require 'st_html/ruing/abstract_renderer'

module StHtml
module Ruing
module Elements
module Renderers
                    
class DefaultItemRenderer < StHtml::Ruing::AbstractRenderer

    
    attr :wrapper_attributes, true
    attr :attributes, true

    attr( :ui_view, true )

    def initialize *opt
        super
        
        @wrapper_attributes = nil
        @attributes = nil
        @ui_view = nil
    end
    
    def render x, *renderoptions

        super
          #
          # mixing between various settings, renderer's, item's and forced ones.

        self.rb= self.class.get_builder unless rb 
          #
          # Must have a builder.
                
        get_wrapper_attributes x

        unless fro[:hide]

            unless block_given?

                rb.div(@wrapper_attributes) { 

                    fro[:editable] ? \
                        render_input(x) : \
                        render_value(x)
                }
            else

                yield x, @wrapper_attributes, rb, ro
            end

        end

        rb.target!
    end


    protected


    def render_input x

        get_input_attributes x

        get_ui_view x

        unless block_given?

          %-Don't know how to render input for this item.\n- \
            + %-  Item class: #{x.class}\n- \
            + %-  Item renderer class: #{self.class}- 
        else
            yield x, @attributes, @ui_view, rb, fro
        end

        false
    end


    def render_value x

        get_value_attributes x

        get_ui_view x

        unless block_given?

            rb.div(@attributes) do 
                rb.target! << @ui_view.render(x.value)
                rb.target! << x.editor.edit(x) if x.editor

            end
        else
            yield x, @attributes, @ui_view, rb, fro
        end

        false
    end


    def get_wrapper_attributes element

        if cached?
            @wrapper_attributes[:id] = element.get_item_id  
            return 
        end

        @wrapper_attributes = { :id => element.get_item_id  }
        @wrapper_attributes[:class] = "form_item #{element.name}"

        html_options :wrapper, @attributes
          #
          # Completing html options
    end

    def get_input_attributes element

        if cached?
            @attributes[:id] = element.get_input_id  
            @attributes[:name] = @attributes[:id]
            return 
        end

        @attributes = { :id => element.get_input_id }
        @attributes[:name] = @attributes[:id]
        @attributes[:class] = "form_input"

        html_options :input, @attributes
          #
          # Completing html options

    end

    def get_value_attributes element

        if cached?
            @attributes[:id] = element.get_input_id  
            return 
        end

        @attributes = { :id => element.get_input_id }
        @attributes[:class] = "form_value"

        html_options :value, @attributes
          #
          # Completing html options

    end
    

    def get_ui_view element

        #
        # Exit immediately when cached
        #
        return if cached?
        
        #
        # Preferring client view 
        #
        @ui_view = fro[:ui_view]
        return if @ui_view
        
        #
        # Guessing best view for value of the element
        #
        @ui_view = fro[:ui_view_factory].get( \
                    element.value.class.to_s.underscore, \
                    fro[:ui_view_factory_options] || {} ) if fro[:ui_view_factory]
        return if @ui_view

        #
        # Fallback to unknows view
        #
        @ui_view = StHtml::UiViews::Factory.get 'unknown' 

    end

    
    def html_options _for, store
    
        return unless fro.has_key? :html_options
        
        o = fro[:html_options]

        if o.has_key? _for

            o[_for].delete(:id) # :id is created internally, ignoring others
            
            if o[_for][:class]
                #
                # First get html class stuff with special threatment
                store[:class] << " " + ( o[_for][:class].is_a?(Array) ? 
                                                    o[_for][:class].join(" ") : 
                                                    o[_for][:class] )
                o[_for].delete(:class)
            end
            store.merge!( o[_for] )
              #
              # Record what remains
        end
    end
    
end
    
end
end
end
end
