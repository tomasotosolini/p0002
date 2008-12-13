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

class AbstractEditor


    attr( :options, true )

    # we don want that values assigned here are modified for external operations
    def initialize( *opt )
        @options = extract_va_options( opt )
    end


    # this thethod fully replaces the ui element originating from x, with the stand alone editable version
    def edit(page, x, *editoptions)
    end
end

end
end

