# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'

require 'support/util'

class T03_Vararg < Test::Unit::TestCase

    def test_vararg
      
      assert_equal( "test1", method_w_extraction("v1", "v2", :value1 => "test1", :value2 => "test2" )[2][:value1] )  
      assert_equal( "test1", method_w_extraction("v1", "v2", {:value1 => "test1", :value2 => "test2"} )[2][:value1] )  
        
      assert_equal( "test1", method_wo_extraction("v1", "v2", :value1 => "test1", :value2 => "test2" )[2][0][:value1] )  
      assert_equal( "test1", method_wo_extraction("v1", "v2", {:value1 => "test1", :value2 => "test2"} )[2][0][:value1] )  

      assert_nil( method_wo_extraction("v1", "v2", {:value1 => "test1", :value2 => "test2"} )[2][1] )  
    end
    
    private
    
    def method_w_extraction x1,x2,*x3
        return [x1,x2, extract_va_options(x3)]
    end
    def method_wo_extraction x1,x2,*x3
        return [x1,x2, x3]
    end
end
