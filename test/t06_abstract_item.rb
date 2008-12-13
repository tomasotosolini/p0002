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

require 'st_html/ruing/ruing'
require 'st_html/ruing/abstract_item'

class T06_AbstractItem < Test::Unit::TestCase

    def test_abstract_item

        assert_nothing_raised do 
          ai = StHtml::Ruing::AbstractItem.new "myname", :option1 => "a", :option2 => "b"
        end
    end
    
    def test_names

        assert_raise StHtml::Ruing::Exception do 
          ai = StHtml::Ruing::AbstractItem.new nil
        end
        assert_raise StHtml::Ruing::Exception do 
          ai = StHtml::Ruing::AbstractItem.new ""
        end
        assert_raise StHtml::Ruing::Exception do 
          ai = StHtml::Ruing::AbstractItem.new "   "
        end
        assert_nothing_raised do 
          ai = StHtml::Ruing::AbstractItem.new :mysymbol
          assert ai.name.eql?(:mysymbol), 'Wrong name'
        end
        assert_nothing_raised do 
          ai = StHtml::Ruing::AbstractItem.new 5, :option1 => "a", :option2 => "b"
          assert ai.name.eql?(5), 'Wrong name'
        end
        assert_nothing_raised do 
            #
            # Objects as names(need only to_s not empty...)
            #
          ai = StHtml::Ruing::AbstractItem.new self.class, :option1 => "a", :option2 => "b"
          assert ai.name.eql?(self.class), 'Wrong name'
        end
    end
    
end
