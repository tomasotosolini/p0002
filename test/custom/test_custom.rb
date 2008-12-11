
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


