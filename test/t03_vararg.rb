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

require 'support/util'

class T03_Vararg < Test::Unit::TestCase

    def test_vararg
      
      assert_equal( "test1", method_w_extraction_wh("v1", "v2", :value1 => "test1", :value2 => "test2" )[2][:value1] )  
      assert_equal( "test1", method_w_extraction_wh("v1", "v2", {:value1 => "test1", :value2 => "test2"} )[2][:value1] )  
        
      assert_equal( "test1", method_wo_extraction("v1", "v2", :value1 => "test1", :value2 => "test2" )[2][0][:value1] )  
      assert_equal( "test1", method_wo_extraction("v1", "v2", {:value1 => "test1", :value2 => "test2"} )[2][0][:value1] )  

      assert_nil( method_wo_extraction("v1", "v2", {:value1 => "test1", :value2 => "test2"} )[2][1] )  
    end
    
    def test_arrays

        # using want_hash option
      assert_equal( {}, method_w_extraction_wh("v1", "v2")[2] ) 
        # using want_array option
      assert_equal( [], method_w_extraction_wa("v1", "v2")[2] ) 
      
        # using both same result
      assert_equal( {:b => "b", :c => "c"}, method_w_extraction_wh("v1", "v2", :b => "b", :c => "c")[2] )  
      assert_equal( {:b => "b", :c => "c"}, method_w_extraction_wa("v1", "v2", :b => "b", :c => "c")[2] )  
      assert_equal( [nil], method_w_extraction_wh("v1", "v2", nil )[2] )  
      assert_equal( [nil], method_w_extraction_wa("v1", "v2", nil )[2] )  
      assert_equal( ["v3", "v4"], method_w_extraction_wh("v1", "v2", "v3", "v4" )[2] )  
      assert_equal( ["v3", "v4"], method_w_extraction_wa("v1", "v2", "v3", "v4" )[2] )  
    end

    private
    
    def method_w_extraction_wh x1,x2,*x3
        return [x1,x2, extract_va_options(x3)] 
    end
    def method_w_extraction_wa x1,x2,*x3
        return [x1,x2, extract_va_options(x3, false)] 
    end
    def method_wo_extraction x1,x2,*x3
        return [x1,x2, x3]
    end
end
