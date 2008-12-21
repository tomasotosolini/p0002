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

require 'st_html/ruing/abstract_serializer'
require 'st_html/ruing/copyable'


module StHtml
module Ruing
module Elements
module Serializers
                    
class DefaultItemSerializer < StHtml::Ruing::AbstractSerializer
    
    def value_from_params x, params
        
        x.value= params[ x.input_id ]
    end
    
    def copy
        
        rv = unless block_given? 
            DefaultItemSerializer.new self.options
        else
            yield(self.options) || nil
        end

        rv
    end
end
    
end
end
end
end

