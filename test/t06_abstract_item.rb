# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'

require 'st_html/ruing/abstract_item'

class T06_AbstractItem < Test::Unit::TestCase

    def test_abstract_item

        ai = StHtml::Ruing::AbstractItem.new "myname", :option1 => "a", :option2 => "b"
    end
    
end
