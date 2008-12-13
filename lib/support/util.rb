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
