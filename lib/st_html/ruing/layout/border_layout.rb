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

class BorderLayout 
    
    #
    # We are layout managers
    #
    include LayoutManager

    #
    # Namespaces
    #
    RUING_NS = StHtml::Ruing

    
    CENTER = 	0
    TOP = 	1
    RIGHT = 	2
    BOTTOM = 	3
    LEFT =	4

    attr( :layout_components )

    def initialize(*layoutoptions)
        
        lo = extract_va_options( layoutoptions )
            # TODO forse qui si puo prevedere di togliere pezzi ecc...

        #
        # Checking layout components
        #
        [ :center, :top, :right, :bottom, :left ].each do |where|
              # nil is allowed for components and means render empty 
            if !lo[where].nil? \
                and ( \
                    !lo[where].respond_to?(:renderer) \
                    or !lo[where].renderer.respond_to?(:render) )
            
              raise RUING_NS::Exception, \
                  "Invalid layout component."
            end
        end
        
        begin
            @layout_components = {
                CENTER =>   lo[:center],
                TOP =>      lo[:top],
                RIGHT =>    lo[:right],
                BOTTOM =>   lo[:bottom],
                LEFT =>     lo[:left]
            }
        rescue Exception => exception
            raise RUING_NS::Exception, \
              "Failed to instantiate layout component.\n" \
              + "Original exception: #{exception}, backtrace: #{exception.backtrace}"
        end
    end


    def add(item)
        add nil, item
    end
    def add layout_constraint, component
        layout_constraint = CENTER if layout_constraint.nil? || ![CENTER, TOP, RIGHT, BOTTOM, LEFT].include?(layout_constraint.to_i)
        @layout_components[layout_constraint] = component
    end

    def remove layout_constraint
        layout_constraint = CENTER if layout_constraint.nil? || ![CENTER, TOP, RIGHT, BOTTOM, LEFT].include?(layout_constraint.to_i)
        @layout_components[layout_constraint] = nil
    end

    def layout *layoutoptions
        lo = extract_va_options layoutoptions

        b = lo[:builder] || Builder::XmlMarkup.new(:indent=>2)

        b.table do
            b.tr do
                b.td( {:colspan => 3, :class => :top} ) do
                    b.target! << @layout_components[TOP].renderer.render(@layout_components[TOP], lo) if @layout_components[TOP]
                end
            end
            b.tr do
                b.td({:class => :left}) do
                    b.target! << @layout_components[LEFT].renderer.render(@layout_components[LEFT], lo) if @layout_components[LEFT]
                end
                b.td({:class => :center}) do
                    b.target! << @layout_components[CENTER].renderer.render(@layout_components[CENTER], lo) if @layout_components[CENTER]
                end
                b.td({:class => :right}) do
                    b.target! << @layout_components[RIGHT].renderer.render(@layout_components[RIGHT], lo) if @layout_components[RIGHT]
                end
            end
            b.tr do
                b.td( {:colspan => 3, :class => :bottom} ) do
                    b.target! << @layout_components[BOTTOM].renderer.render(@layout_components[BOTTOM], lo) if @layout_components[BOTTOM]
                end
            end
        end
        b.target!
    end

end

end
end
end














    
 