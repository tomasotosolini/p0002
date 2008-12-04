
require 'st_html_license'

require 'st_html/ruing/elements/renderers/default_item_renderer'

module StHtml
module Ruing
module Elements
module Renderers
                            
class TextFieldRenderer < DefaultItemRenderer 

    def render_input(x)

        return super { |element, attributes, ui_view, builder, irenderoptions|

            attributes[:type] = :text

            attributes[:value] = ui_view.render(element.value)

            builder.input(attributes) 
        }

    end

end
    
end
end
end
end
