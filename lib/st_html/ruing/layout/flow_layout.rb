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

require 'support/util'

require 'st_html/ruing/ruing'
require 'st_html/ruing/layout_manager'

module StHtml
module Ruing
module Layout

class FlowLayout 
    
    #
    # We are layout managers
    #
    include LayoutManager

    #
    # Namespaces
    #
    RUING_NS = StHtml::Ruing
    
    attr( :layout_components )
    attr( :align )

    def initialize(*layoutoptions)
        
        lo = extract_va_options( layoutoptions )
            # TODO forse qui si puo prevedere di togliere pezzi ecc...
            
        @align = lo[:align]
        @layout_components = []
    end


    def add layout_constraint, component
        if layout_constraint.nil?
          @layout_components << component
        else
            @layout_components.insert layout_constraint, component
        end
    end

    def remove layout_constraint
        @layout_components.clear if layout_constraint.nil?
        @layout_components.delete_at layout_constraint
    end

    def layout *layoutoptions
        lo = extract_va_options layoutoptions

        b = lo[:builder] || Builder::XmlMarkup.new(:indent=>2)

        b.div( :style => "align: #{@align}" ) do 
            @layout_components.each do |component|
                b.span do 
                    b.target! << component.renderer.render(component, lo)
                end
            end
        end
        b.target!
    end

end

end
end
end














    
 