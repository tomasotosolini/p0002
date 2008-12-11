# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

require 'test/unit'
 
require 'st_html/ruing/ruing'
require 'st_html/ruing/elements/text_field.rb'

require 'st_html/ui_views/factory'

class T02_TextField < Test::Unit::TestCase

    def test_text_field

        assert_nothing_raised do 
          tf = StHtml::Ruing::Elements::TextField.new "myname", :option1 => "a", :option2 => "b"
        end
    
    end

    
    def test_renderer
    
      tf = StHtml::Ruing::Elements::TextField.new "myname", :renderer_options => { :option1 => "a", :option2 => "b" }
      
      assert_not_nil tf.renderer
      assert_kind_of StHtml::Ruing::Elements::Renderers::TextFieldRenderer, tf.renderer, 'Wrong renderer class.'
    
    end

    def test_render_ne
        
      tf = StHtml::Ruing::Elements::TextField.new "myname", :option1 => "a", 
        :option2 => "b", 
        :renderer_options => { 
        :option1 => "a", 
        :option2 => "b", 
        :builder => StHtml::Ruing::AbstractRenderer.get_builder({ :indent => 0 }),
        :ui_view_factory =>  StHtml::UiViews::Factory 
      }

      tf.value="hello"
#      rv = tf.renderer.render(tf, :editable => false )
      assert_equal( \
%-<div class=\"form_item myname\" id=\"myname_item\"><div class=\"form_value\" id=\"myname\">hello</div></div>-, \
tf.renderer.render(tf, :editable => false ), 'Wrong rendering.')

    end
    def test_render_e
        
      tf = StHtml::Ruing::Elements::TextField.new "myname", :option1 => "a", 
        :option2 => "b", 
        :renderer_options => { 
        :option1 => "a", 
        :option2 => "b", 
        :builder => StHtml::Ruing::AbstractRenderer.get_builder({ :indent => 0 }),
        :ui_view_factory =>  StHtml::UiViews::Factory 
      }

      tf.value="hello"

      assert_substrings_cover( [ \
%-<div-, \
%-class="form_item myname"-, \
%-class="form_item myname"><input-, \
%-id="myname_item"-, \
%-id="myname_item"><input-, \
%-type="text"-, \
%-type="text"/></div>-, \
%-class="form_input"-, \
%-class="form_input"/></div>-, \
%-id="myname"-, \
%-id="myname"/></div>-, \
%-name="myname"-, \
%-name="myname"/></div>-, \
%-value="hello"-, \
%-value="hello"/></div>-],\
tf.renderer.render(tf, :editable => true ))
        
    end
end

