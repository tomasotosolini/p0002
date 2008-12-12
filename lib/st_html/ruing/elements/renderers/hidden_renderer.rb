
require 'st_html'
require 'st_html_license'
require 'st_html/ruing/elements/renderers/default_item_renderer'

module StHtml
module Ruing
module Elements
module Renderers
                    
class HiddenRenderer < DefaultItemRenderer 

    def render x, *renderoptions

        super { |element, attributes, builder, irenderoptions|

            render_input(element) if fro[:editable]
              #
              # When not editable no render, never call render_value
        }
    end


    def render_input x

        return super { |element, attributes, ui_view, builder, irenderoptions|

            attributes.merge :type => :hidden, \
              :value => ui_view.render(element.value) 

            builder.input attributes 
        }
    end
end

end
end
end
end

