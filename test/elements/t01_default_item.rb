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
 
require 'elements/test_element'
 
require 'st_html/ruing/ruing'
require 'st_html/ruing/elements/default_item.rb'

class T01_DefaultItem < Test::Unit::TestCase

    include TestElement
    
    def test_creation

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
