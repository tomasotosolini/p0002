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

require 'st_html'
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

