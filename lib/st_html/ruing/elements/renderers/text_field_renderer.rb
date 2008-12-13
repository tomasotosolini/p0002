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
