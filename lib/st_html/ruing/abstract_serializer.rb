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


module StHtml
module Ruing
    
class AbstractSerializer

    attr :options, true 
    

    def initialize *serializer_options 
        @options = extract_va_options( serializer_options )
    end


    def load_from_flattened_hash x, h

    end

end
end
end
