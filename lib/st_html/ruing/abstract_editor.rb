
require 'st_html_license'

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

