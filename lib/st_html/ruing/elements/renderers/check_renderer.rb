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
    
class CheckRenderer < DefaultItemRenderer 

    
    def render_input x

        return super { |element, attributes, ui_view, builder, irenderoptions|

            attributes_ = attributes.merge \
                    :type => :checkbox
          
            attributes_ = attributes_.merge( :checked => true ) if element.checked?

            builder.input attributes_
        }

    end

    
    def render_value x

        super { |element, attributes, ui_view, builder, irenderoptions|
            
            #
            # Here ui_view is built in super using the element.checked? boolean
            # value
            #
            builder.div(attributes) do
                
                builder.target! << ui_view.render(element.value)
            end

        }

    end
end
    
end
end
end
end

