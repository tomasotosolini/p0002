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

# What means this test?
#
# This test is often required because xml builder tend to swap output substring
# without control, so it is unpredictable whether the output will be
# <tag option1=value1 option2=value2 >...</tag>
# or
# <tag option2=value2 option1=value1 >...</tag>
# Since for out purphose the two outputs are equivalent, we must ba able to 
# check the substring presence rather that the whole output.
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
        assert @l.size.eql?(0) && @s.strip.empty?, message || "Still have components. list=(#{@l.join(',')}), str=(#{@s})"
    end
    def assert_not_same_substrings list, str, message=nil
        @l = list
        @s = str
        process 
        assert !(@l.size.eql?(0) && @s.strip.empty?), message || "Same components. list=(#{@l.join(',')}), str=(#{@s})"
    end
    def assert_substrings_cover list, str, message=nil
        @l = list
        @s = str
        process
        assert( (@l.size >= 0) && @s.strip.empty?, message || "Substring don't cover. list=(#{@l.join(',')}), str=(#{@s})")
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


