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
