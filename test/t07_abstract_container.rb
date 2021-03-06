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
require 'st_html/ruing/abstract_container'

class T07_AbstractContainer < Test::Unit::TestCase

    #
    # No test for costruction, is like an abstract item
    # 
   
    
    def test_contained_items

        item_to_be_inserted = StHtml::Ruing::AbstractItem.new "myitem"
        item_not_to_be_inserted = StHtml::Ruing::AbstractItem.new "myitem"
        container = StHtml::Ruing::AbstractContainer.new "mycontainer"

        assert_respond_to item_to_be_inserted, :input_id, 'Can\'t find method before add'
        assert_equal 'myitem', item_to_be_inserted.input_id, 'Wrong input id before add'
        assert_respond_to item_not_to_be_inserted, :input_id, 'Can\'t find method before add'
        assert_equal 'myitem', item_not_to_be_inserted.input_id, 'Wrong input id before add'
          #
          # at the beginning elements are functionally the same
          
        container.add item_to_be_inserted 
          #
          # we suppose item_to_be_inserted changes his behavior
        
        assert_respond_to item_to_be_inserted, :input_id, 'Can\'t find method after add'
        assert_equal 'mycontainer.myitem', item_to_be_inserted.input_id, 'Wrong input id after add'
          #
          # demostrating item_to_be_inserted changed his behavior

        assert_respond_to item_not_to_be_inserted, :input_id, 'Can\'t find method after add'
        assert_equal 'myitem', item_not_to_be_inserted.input_id, 'Wrong input id after add'
          #
          # demostrating item_not_to_be_inserted didn't change his behavior
        
        item_to_be_inserted = container.remove 0
                
        assert_respond_to item_to_be_inserted, :input_id, 'Can\'t find method after remove'
        assert_equal item_to_be_inserted.input_id, "myitem", 'Wrong input id after remove'
          #
          # demostrating item_to_be_inserted returned to original shape
        
        assert_respond_to item_not_to_be_inserted, :input_id, 'Can\'t find method after add'
        assert_equal 'myitem', item_not_to_be_inserted.input_id, 'Wrong input id after add'
          #
          # demostrating item_not_to_be_inserted is not affected with other's modifications
    end

    def test_multiple_add

        ac = StHtml::Ruing::AbstractContainer.new "mycontainer", :option1 => "a", :option2 => "b"
        i1 = StHtml::Ruing::AbstractItem.new "myitem1"
        i2 = StHtml::Ruing::AbstractItem.new "myitem2"
        i3 = StHtml::Ruing::AbstractItem.new "myitem3"
        
        ac.add i1, i2, i3
    end
    
    #
    # Testing correctedness of path
    #
    def test_container_recursion01
        
        l1 = StHtml::Ruing::AbstractContainer.new "level1"
        l2 = StHtml::Ruing::AbstractContainer.new "level2"
        i1 = StHtml::Ruing::AbstractItem.new "item1"
        i2 = StHtml::Ruing::AbstractItem.new "item2"
        
        l2.add i1
        l2.add i2
        l1.add l2
        
        assert_equal 'level1', l1.input_id, 'Level 1 group wrong'
        assert_equal 'level1.level2', l2.input_id, 'Level 2 group wrong'
        assert_equal 'level1.level2.item1', i1.input_id, 'Item1 wrong'
        assert_equal 'level1.level2.item2', i2.input_id, 'Item2 wrong'
          
    end
    #
    # Testing insertion order independency 
    #
    def test_container_recursion02
        
        l1 = StHtml::Ruing::AbstractContainer.new "level1"
        l2 = StHtml::Ruing::AbstractContainer.new "level2"
        i1 = StHtml::Ruing::AbstractItem.new "item1"
        i2 = StHtml::Ruing::AbstractItem.new "item2"
        
        l2.add i1
        l1.add l2
        l2.add i2
        
        assert_equal 'level1', l1.input_id, 'Level 1 group wrong'
        assert_equal 'level1.level2', l2.input_id, 'Level 2 group wrong'
        assert_equal 'level1.level2.item1', i1.input_id, 'Item1 wrong'
        assert_equal 'level1.level2.item2', i2.input_id, 'Item2 wrong'
          
        l1 = StHtml::Ruing::AbstractContainer.new "level1"
        l2 = StHtml::Ruing::AbstractContainer.new "level2"
        i1 = StHtml::Ruing::AbstractItem.new "item1"
        i2 = StHtml::Ruing::AbstractItem.new "item2"
        
        l1.add l2
        l2.add i2
        l2.add i1
        
        assert_equal 'level1', l1.input_id, 'Level 1 group wrong'
        assert_equal 'level1.level2', l2.input_id, 'Level 2 group wrong'
        assert_equal 'level1.level2.item1', i1.input_id, 'Item1 wrong'
        assert_equal 'level1.level2.item2', i2.input_id, 'Item2 wrong'
          
    end


    def test_ancestor_removal
        
        l1 = StHtml::Ruing::AbstractContainer.new "level1"
        l2 = StHtml::Ruing::AbstractContainer.new "level2"
        l3 = StHtml::Ruing::AbstractContainer.new "level3"
        i1 = StHtml::Ruing::AbstractItem.new "item1"
        i2 = StHtml::Ruing::AbstractItem.new "item2"
        
        l2.add i1
        l2.add i2
        l1.add l2
        l3.add l1
        
        assert_equal 'level3.level1.level2.item2', i2.input_id, 'Item2 wrong'
        
        l1.remove 0
        
        assert_equal 'level2.item2', i2.input_id, 'Item2 wrong'
          # i2 is still contained in "l2"
        
        l1 = StHtml::Ruing::AbstractContainer.new "level1"
        l2 = StHtml::Ruing::AbstractContainer.new "level2"
        l3 = StHtml::Ruing::AbstractContainer.new "level3"
        i1 = StHtml::Ruing::AbstractItem.new "item1"
        i2 = StHtml::Ruing::AbstractItem.new "item2"
        
        l2.add i1
        l2.add i2
        l1.add l2
        l3.add l1
        
        l3.remove 0
        
        assert_equal 'level1.level2.item2', i2.input_id, 'Item2 wrong'
    end
    
    def test_value
        # setup
        l1 = StHtml::Ruing::AbstractContainer.new "level1"
        l2 = StHtml::Ruing::AbstractContainer.new "level2"
        l3 = StHtml::Ruing::AbstractContainer.new "level3"
        i1 = StHtml::Ruing::AbstractItem.new "item1"
        i1.value= "value1"
        i2 = StHtml::Ruing::AbstractItem.new "item2"
        i2.value= "value2"
        #
        l2.add i1
        l2.add i2
        l1.add l2
        l3.add l1

        # value read
        assert_equal l2.value['item1'], 'value1', 'Value wrong.'
        assert_equal l2.value['item2'], 'value2', 'Value wrong.'
        assert_equal l1.value, { 'level2' => { 'item1' => 'value1', 'item2' => 'value2' }}, 'Value wrong.'
        
        # value write
        l3.value= nil 
        assert l2.value['item1'].nil?, 'Value wrong.'
        assert l2.value['item2'].nil?, 'Value wrong.'
        l3.value= { 'level1' => { 'level2' => { 'item1' => 'v1', 'item2' => 'v2' }}} 
        assert_equal l2.value['item1'], 'v1', 'Value wrong.'
        assert_equal l2.value['item2'], 'v2', 'Value wrong.'
    end


    def test_trees
        # setup
        l1 = StHtml::Ruing::AbstractContainer.new "level1"
        l2 = StHtml::Ruing::AbstractContainer.new "level2"
        l3 = StHtml::Ruing::AbstractContainer.new "level3"
        i1 = StHtml::Ruing::AbstractItem.new "item1"
        i1.value= "value1"
        i2 = StHtml::Ruing::AbstractItem.new "item2"
        i2.value= "value2"
        #
        l2.add i1
        l2.add i2
        l1.add l2
        l3.add l1

        assert_equal i1, l3.item_tree['level1']['level2']['item1'], 'Wrong item.'
        x = { 'item1' => i1, 'item2' => i2 }
        assert_equal x, l3.item_tree['level1']['level2'], 'Wrong item.'
    end
    
    def test_null_path
        
        # setup
        l1 = StHtml::Ruing::AbstractContainer.new "level1", :transparent => true
        l2 = StHtml::Ruing::AbstractContainer.new "level2"
        l3 = StHtml::Ruing::AbstractContainer.new "level3"
        i1 = StHtml::Ruing::AbstractItem.new "item1"
        i2 = StHtml::Ruing::AbstractItem.new "item2"
        
        l2.add i1
        l2.add i2
        l1.add l2
        l3.add l1
        
        # assertions
        assert_equal 'level3.level2.item1', i1.input_id, 'Item1 name wrong'
        assert_equal 'level3.level2.item2', i2.input_id, 'Item2 name wrong'
    end
    
end

