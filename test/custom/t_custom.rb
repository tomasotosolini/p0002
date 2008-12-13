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
 
require 'test/unit'
require 'test/custom/test_custom'

class T00_TestCustom < Test::Unit::TestCase

    def test_custom

        assert_same_substrings(["a", "b", "c"], "a b c", "Failed testing the assertion.")
        assert_same_substrings(["c", "a", "b"], "a b c", "Failed testing the assertion.")
        assert_same_substrings(["a", "b", "c"], "c b a", "Failed testing the assertion.")
        assert_same_substrings(["a", "b", "c"], "  a  b c", "Failed testing the assertion.")
        
        assert_not_same_substrings(["a", "b", "c"], "a b", "Failed testing the assertion.")
        assert_not_same_substrings(["a", "b", "c"], "a bc", "Failed testing the assertion.")
        assert_not_same_substrings(["a", "b", "c", "bc"], "a bc", "Failed testing the assertion.")

        assert_same_substrings(["a", "bc", "b", "c"], "  a  bc b c", "Failed testing the assertion.")
    end
end
