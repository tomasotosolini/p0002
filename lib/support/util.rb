
require 'st_html_license'

module Kernel
    
    #
    # Returns the hash of the variable args part, if present or empty hash.
    #
    def extract_va_options x, want_hash = true
        if x.size.eql?(0) then
          if want_hash then 
            return {}
          else
            return []
          end
        end
        return x[0] if x[0].is_a?(Hash)
        return x 
    end
    
end
