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

module St::Html
module Ruing

class AbstractSerializer

    attr( :options, true )
    
      #
      # we don't want that values assigned here are modified from external 
      # operations
      #
    def initialize( *opt )
        @options = extract_va_options( opt )
    end

    
    def serialize
        return value
    end

    
    def unserialize(serialized_data)
        value= serialized_data
    end
        
      #
      # we you recurse over this has do not resolve key, simply recur with the 
      # whole hash
      #
    def load_from_flattened_hash(element, hash)

    end

end
end
end
