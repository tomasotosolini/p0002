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
        assert @l.size.eql?(0) && @s.strip.empty?, message || "Not same substrings.\n\nlist=(#{@l.join(',')}),\n\nstr=(#{@s})"
    end
    def assert_not_same_substrings list, str, message=nil
        @l = list
        @s = str
        process 
        assert !(@l.size.eql?(0) && @s.strip.empty?), message || "Same substrings.\n\nlist=(#{@l.join(',')}),\n\nstr=(#{@s})"
    end
    def assert_substrings_cover list, str, message=nil
        @l = list
        @s = str
        process
        assert( (@l.size >= 0) && @s.strip.empty?, message || "Substring don't cover.\n\nlist=(#{@l.join(',')}),\n\nstr=(#{@s})")
    end
    def assert_substrings_digroups_cover list, str, message=nil
        @l = list
        @s = str
        process_by_groups
        
        # we want that all the single components were used and removed only 
        # the digroups have one residual value
        assert( (@l.size >= 0) \
                && (@l.all? { |x| x.is_a?(Array) && (x.size.eql?(1)) }) \
                && @s.strip.empty?, message || "Substring don't digroup-cover .\n\nlist=(#{@l.join(',')}),\n\nstr=(#{@s})")
    end
    def assert_substrings_digroups_dont_cover list, str, message=nil
        @l = list
        @s = str
        process_by_groups
        
        assert( !((@l.size >= 0) \
                && (@l.all? { |x| x.is_a?(Array) && (x.size.eql?(1)) }) \
                && @s.strip.empty?), message || "Substring digroup-cover.\n\nlist=(#{@l.join(',')}),\n\nstr=(#{@s})")
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
    def process_by_groups 
        upper = @l.size-1
        for i in 0..upper do
            if @l[upper - i].is_a?(Array) then
                for j in 0...(@l[upper - i].size) do 
                    if @s.sub!(/\s{1}#{@l[upper - i][j]}\s{1}/, "  ") then 
                      @l[upper - i].delete_at(j)
                    elsif @s.sub!(/\s{1}#{@l[upper - i][j]}$/, " ") then 
                      @l[upper - i].delete_at(j)
                    elsif @s.sub!( /^#{@l[upper - i][j]}\s{1}/, " ") then 
                      @l[upper - i].delete_at(j)
                    end
                end
                @l.delete_at(upper - i) if @l[upper - i].size.eql?(0)
            else    
                if @s.sub!(/\s{1}#{@l[upper - i]}\s{1}/, "  ") then 
                  @l.delete_at(upper - i)
                elsif @s.sub!(/\s{1}#{@l[upper - i]}$/, " ") then 
                  @l.delete_at(upper - i)
                elsif @s.sub!( /^#{@l[upper - i]}\s{1}/, " ") then 
                  @l.delete_at(upper - i)
                end
            end
            break if @s.strip.empty?
        end 
    end
end


