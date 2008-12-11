
require 'st_html_license'

module Kernel
    
    # 
    # Extract from the variable pert of the parameters an hash or an array
    # depending on what king of variable parameters are passed.
    # The result can be both used directly both passed as variable arg to 
    # other methods.
    #
    def extract_va_options va_list, want_hash = true
        
        if va_list.size.eql?(0) then
          want_hash ? {} : []
        else
          va_list[0].is_a?(Hash) ? va_list[0] : va_list
        end
    end
    
end
