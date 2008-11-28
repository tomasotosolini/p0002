
require 'st_html_license'

module Kernel
    
    #
    # Returns the hash of the variable args part, if present or empty hash.
    #
    def extract_va_options x
        return (x.size.eql?(1) && !x[0].nil? && x[0].is_a?(Hash)) ?  x[0] : {}
    end
    
end
