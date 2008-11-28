# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'

require 'st_html/ruing/ruing'
require 'st_html/ruing/abstract_item'
require 'st_html/ruing/abstract_container'

class T07_AbstractContainer < Test::Unit::TestCase

    def test_abstract_container

        assert_nothing_raised do 
          ac = StHtml::Ruing::AbstractContainer.new "mycontainer", :option1 => "a", :option2 => "b"
        end
    end
    
    def test_contained_items

        item_to_be_inserted = StHtml::Ruing::AbstractItem.new "myitem"
        item_not_to_be_inserted = StHtml::Ruing::AbstractItem.new "myitem"
        container = StHtml::Ruing::AbstractContainer.new "mycontainer"

        assert_respond_to item_to_be_inserted, :get_input_id, 'Can\'t find method before add'
        assert_equal 'myitem', item_to_be_inserted.get_input_id, 'Wrong input id before add'
        assert_respond_to item_not_to_be_inserted, :get_input_id, 'Can\'t find method before add'
        assert_equal 'myitem', item_not_to_be_inserted.get_input_id, 'Wrong input id before add'
          #
          # at the beginning elements are functionally the same
          
        container.add item_to_be_inserted 
          #
          # we suppose item_to_be_inserted changes his behavior
        
        assert_respond_to item_to_be_inserted, :get_input_id, 'Can\'t find method after add'
        assert_equal 'mycontainer.myitem', item_to_be_inserted.get_input_id, 'Wrong input id after add'
          #
          # demostrating item_to_be_inserted changed his behavior

        assert_respond_to item_not_to_be_inserted, :get_input_id, 'Can\'t find method after add'
        assert_equal 'myitem', item_not_to_be_inserted.get_input_id, 'Wrong input id after add'
          #
          # demostrating item_not_to_be_inserted didn't change his behavior
        
        item_to_be_inserted = container.remove 0
                
        assert_respond_to item_to_be_inserted, :get_input_id, 'Can\'t find method after remove'
        assert_equal item_to_be_inserted.get_input_id, "myitem", 'Wrong input id after remove'
          #
          # demostrating item_to_be_inserted returned to original shape
        
        assert_respond_to item_not_to_be_inserted, :get_input_id, 'Can\'t find method after add'
        assert_equal 'myitem', item_not_to_be_inserted.get_input_id, 'Wrong input id after add'
          #
          # demostrating item_not_to_be_inserted is not affected with other's modifications
    end
    
end
