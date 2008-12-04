# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
require 'test/unit'
 
require 'st_html/ruing/ruing'
require 'st_html/ruing/elements/default_item.rb'

class T01_DefaultItem < Test::Unit::TestCase

    def test_default_item

        assert_nothing_raised do 
          di = StHtml::Ruing::Elements::DefaultItem.new "myname", :option1 => "a", :option2 => "b"
        end
    end

    
    def test_renderer
    
      di = StHtml::Ruing::Elements::DefaultItem.new "myname", :renderer_options => { :option1 => "a", :option2 => "b" }
      
      assert_not_nil di.renderer
    
    end

    def test_render

      di = StHtml::Ruing::Elements::DefaultItem.new "myname", :renderer_options => { 
        :option1 => "a", 
        :option2 => "b", 
        :builder => StHtml::Ruing::AbstractRenderer.get_builder({ :indent => 0 }),
        :ui_view_factory =>  StHtml::UiViews::Factory 
      }

      di.value="hello"
      assert_equal( \
%-<div class=\"form_item myname\" id=\"myname_item\"><div class=\"form_value\" id=\"myname\">hello</div></div>-, \
di.renderer.render(di, :editable => false ), 'Wrong rendering.')

    end

    def test_item_direct_methods

      di = StHtml::Ruing::Elements::DefaultItem.new "myname"

      assert_equal( di.renderer.render(di), di.render, 'Wrong direct rendering.')
      assert_equal( di.renderer.render(di, :editable => false), di.render_, 'Wrong direct rendering.')

    end
    
end
