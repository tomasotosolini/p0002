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

require 'st_html/ruing/elements/serializers/default_item_serializer'

module StHtml
module Ruing
module Elements    
module Serializers

class CheckSerializer < DefaultItemSerializer

    #
    # Check are tranmitted setting their value to "on" when checked. This for us
    # means true. 
    #
    def value_from_params x, params
        
        sv =  params[x.input_id] # serialized value
        x.value= !sv.nil? && sv.eql?("on")
    end

    def copy
        super { |options_|
            CheckSerializer.new options_
        }
    end
end

end
end
end
end

