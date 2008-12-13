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

require 'rubygems'
gem 'ruby-debug'
require 'ruby-debug' 

require 'test/unit'
 
class Test::Unit::TestCase

    def assert_same_substrings list, str, message=nil
        @l = list
        @s = str
        process
        assert list.size.eql?(0) && str.strip.empty?, message || "Still have components. list=#{list}, #{str}"
    end
    def assert_not_same_substrings list, str, message=nil
        @l = list
        @s = str
        process 
        assert !(list.size.eql?(0) && str.strip.empty?), message || "Same components. list=#{list}, #{str}"
    end
    def assert_substrings_cover list, str, message=nil
        @l = list
        @s = str
        process
        assert( (list.size >= 0) && str.strip.empty?, message || "Substring don't cover. list=#{list}, #{str}")
    end
    private
    def process 
        upper = @l.size-1
        for i in 0..upper do
            if @s.sub!(/\s{1}#{@l[upper - i]}\s{1}/, "  ") then 
              @l.delete_at(upper - i)
            elsif @s.sub!(/\s{1}#{@l[upper - i]}$/, " ") then 
              @l.delete_at(upper - i)
            elsif @s.sub!( /^#{@l[upper - i]}\s{1}/, " ") then 
              @l.delete_at(upper - i)
            end
            break if @s.strip.empty?
        end 
    end
end


