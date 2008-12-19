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
 

# This is the test file that explains the functionality of this test: find
# whether the string has or not the same not empty components described by the
# array


require 'test/unit'
require 'test/custom/test_custom'

class T00_TestCustom < Test::Unit::TestCase

    def test_custom

        assert_same_substrings(["a", "b", "c"], "a b c", "Failed testing the assertion.")
        assert_same_substrings(["c", "a", "b"], "a b c", "Failed testing the assertion.")
        assert_same_substrings(["a", "b", "c"], "c b a", "Failed testing the assertion.")
        assert_same_substrings(["a", "b", "c"], "  a  b c", "Failed testing the assertion.")
        
        assert_not_same_substrings(["a", "b", "c"], "a b", "Failed testing the assertion.")
        assert_not_same_substrings(["a", "b", "c"], "a b c d", "Failed testing the assertion.")
        assert_not_same_substrings(["a", "b", "c"], "a bc", "Failed testing the assertion.")
        assert_not_same_substrings(["a", "b", "c", "bc"], "a bc", "Failed testing the assertion.")

        assert_same_substrings(["a", "bc", "b", "c"], "  a  bc b c", "Failed testing the assertion.")
        
        # We want to  be sure that the output of a builder:
        # 
        # %-<tag1 x2="b" x1="a"><tag2 x2="b" x1="a">HelloWorld</tag2></tag1>
        # that can be also 
        # %-<tag1 x1="a" x2="b"><tag2 x1="a" x2="b">HelloWorld</tag2></tag1>
        # or
        # %-<tag1 x1="a" x2="b"><tag2 x2="b" x1="a">HelloWorld</tag2></tag1>
        # is "the same" we expect no matter what exactly will be the "real"
        # output at a single instance of the builder
        #
        # From XML point of view and also from ours the 3 strings above are
        # the same so we propose the foolowing as a method to decide if them are 
        # similar
        # 
        # 1. %-<tag1- is always present
        # 2. %-x1="a"- in the first piece may also appear as %-x1="a"><tag2-
        # 3. %-x2="b"- in the first piece may also appear as %-x2="b"><tag2-
        # and so on.
        # Ok: [ %-<tag1-, # for the first,
        #       [ %-x1="a"-, %-x1="a"><tag2- ], # for the second
        #       [ %-x2="2"-, %-x2="2"><tag2- ], # for the third
        # not that %-x1="a"- is also in the second piece, but can appear as
        # %-x1="a">HelloWorld</tag2></tag1>-
        
        
        assert_substrings_digroups_cover( \
          ["<tag1", 
            [%-x1="a"-, %-x1="a"><tag2-], 
            [%-x2="b"-, %-x2="b"><tag2-],
            [%-x1="a"-, %-x1="a">HelloWorld</tag2></tag1>-], 
            [%-x2="b"-, %-x2="b">HelloWorld</tag2></tag1>-],
              ], %-<tag1 x1="a" x2="b"><tag2 x1="a" x2="b">HelloWorld</tag2></tag1>-, "Failed testing the assertion.")
          
        assert_substrings_digroups_cover( \
          ["<tag1", 
            [%-x1="a"-, %-x1="a"><tag2-], 
            [%-x2="b"-, %-x2="b"><tag2-],
            [%-x3="c"-, %-x3="c"><tag2-],
            [%-x1="a"-, %-x1="a">Hello-], 
            [%-x2="b"-, %-x2="b">Hello-], 
            [%-x3="c"-, %-x3="c">Hello-], 
            %-World</tag2></tag1>-,
              ], %-<tag1 x1="a" x2="b" x3="c"><tag2 x1="a" x2="b" x3="c">Hello World</tag2></tag1>-, "Failed testing the assertion.")
          
        #
        # The following string list covers but not in a reasonable way, because
        # we require that some pieces of string are covered by one element xor
        # another, not by one element or another.
        #
        assert_substrings_digroups_dont_cover(["<tag", %-x1="a"-, %-x1="a"/>-, [%-x2="b"-, %-x2="b"/>-]], %-<tag x2="b" x1="a"/>-, "Failed testing the assertion.")
        
    end
end
