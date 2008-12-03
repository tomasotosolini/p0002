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
    
    def test_scaling_wo_cache

      t = Time.new
      
      di = StHtml::Ruing::Elements::DefaultItem.new( "myname")
      
      di.render # run once to calculate internal options  
      
      for i in 0...1000 do
          assert_equal( di.renderer.render(di), di.render, 'Wrong direct rendering.')
      end

      delta = Time.new - t
      # no great expectations
      print delta  
    end
    def test_scaling_w_cache
        
      t = Time.new
      
      di = StHtml::Ruing::Elements::DefaultItem.new( "myname")
      
      di.render # run once to calculate internal options  
      di.renderer.options[:cache] = true # then cache them...
      
      for i in 0...1000 do
          assert_equal( di.renderer.render(di), di.render, 'Wrong direct rendering.')
      end

      delta = Time.new - t
      
      print delta  
    end
    
#    def test_names
#
#        assert_raise StHtml::Ruing::Exception do 
#          ai = StHtml::Ruing::AbstractItem.new nil
#        end
#        assert_raise StHtml::Ruing::Exception do 
#          ai = StHtml::Ruing::AbstractItem.new ""
#        end
#        assert_raise StHtml::Ruing::Exception do 
#          ai = StHtml::Ruing::AbstractItem.new "   "
#        end
#        assert_nothing_raised do 
#          ai = StHtml::Ruing::AbstractItem.new :mysymbol
#          assert ai.name.eql?(:mysymbol), 'Wrong name'
#        end
#        assert_nothing_raised do 
#          ai = StHtml::Ruing::AbstractItem.new 5, :option1 => "a", :option2 => "b"
#          assert ai.name.eql?(5), 'Wrong name'
#        end
#        assert_nothing_raised do 
#            #
#            # Objects as names(need only to_s not empty...)
#            #
#          ai = StHtml::Ruing::AbstractItem.new self.class, :option1 => "a", :option2 => "b"
#          assert ai.name.eql?(self.class), 'Wrong name'
#        end
#    end
    
end
