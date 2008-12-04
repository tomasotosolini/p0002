
require 'st_html_license'

require 'st_html/ruing/abstract_serializer'

module StHtml
module Ruing
module Elements
module Serializers
                    
class DefaultItemSerializer < StHtml::Ruing::AbstractSerializer
    
    def value_from_params x, params
        
        value_hash = {}
        x.get_input_keys.each do |input_key, input_name|
            value_hash[ input_key ] = params[ input_name ]
        end
        x.value=( value_hash )
    end
    
        
    def load_from_flattened_hash(element, hash)
        element.value= hash[element.get_input_id]
    end
end
    
end
end
end
end

