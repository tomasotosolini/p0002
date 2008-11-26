
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
