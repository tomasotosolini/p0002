# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
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
