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
require 'st_html/ruing/elements/hidden.rb'

require 'st_html/ruing/factory.rb'


class T03_Hidden < Test::Unit::TestCase
  
  def test_hidden
      # This test in spite of the ordering, came a little later than the 
      # factory tools
      assert_nothing_raised {
        h = StHtml::Ruing::Factory.get 'hidden', 'fortests'
      }
  end
  
  def test_render_e
      
  end
  def test_render_ne
      
  end
end
