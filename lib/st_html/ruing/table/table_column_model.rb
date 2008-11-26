
require 'st_html_license'
require 'st_html'

require 'support/util'


module StHtml
module Ruing
module Table

class TableColumnModel

    attr( :columns, true ) # to follow the way table model saves data this is a hash

    def initialize
        @columns = []
    end

    def add table_column 
        @columns << table_column
    end

    def count
        return @columns.size
    end

    def identifiers
        return @columns.map{ |x| x.identifier }
    end

    def column( identifier )
        @columns.each do |c|
            return c if c.identifier.eql?(identifier)
        end
        return nil
    end

end

end
end
end
