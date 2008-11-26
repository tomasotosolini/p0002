
require 'st_html_license'
require 'st_html'

require 'support/util'


module StHtml
module Ruing
module Table

class TableColumn

    attr( :cell_item, true ) # the renderer for the data in this column

    attr( :header, true ) # the header value
    attr( :header_item, true ) # the header item

    attr( :identifier, true )  # the column who is interested

    def initialize( *opt )
        options = extract_va_options( opt )

        @cell_item = options.delete(:cell_item)

        @header_item = options.delete(:header_item) || @cell_item

        @identifier = options.delete(:identifier) 

        @header = options.delete(:header) || @identifier 
    end

end

end
end
end
