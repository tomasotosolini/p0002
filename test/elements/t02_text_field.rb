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
require 'test/elements/test_element'
require 'test/custom/test_custom'
require 'st_html/ruing/ruing'
require 'st_html/ruing/elements/text_field.rb'
require 'st_html/ui_views/factory'


class T02_TextField < Test::Unit::TestCase

    include TestElement

    def test_creation

        assert_nothing_raised do 
          tf = StHtml::Ruing::Elements::TextField.new "myname"
        end
        assert_nothing_raised do
          tf = StHtml::Ruing::Factory.get "text_field", "myname"
        end
    
        tfn = StHtml::Ruing::Elements::TextField.new "myname"
        tff = StHtml::Ruing::Factory.get "text_field", "myname"
        
        assert tfn.is_a?(tff.class), 'Initialization equality failure(type).'
        assert_equal tfn.name, tff.name, 'Initialization equality failure(name).'
    end

    def test_renderer_initialization
    
      tfn = StHtml::Ruing::Elements::TextField.new "myname"
      assert_not_nil tfn.renderer, 'Renderer not initialized.'
      assert tfn.renderer.is_a?(StHtml::Ruing::Elements::Renderers::TextFieldRenderer), 'Renderer wrong.'
    
      tfn = StHtml::Ruing::Elements::TextField.new "myname", :renderer => StHtml::Ruing::Elements::Renderers::TextFieldRenderer.new( :option1 => "a", :option2 => "b" )
      assert_not_nil tfn.renderer, 'Renderer not initialized.'
      assert tfn.renderer.is_a?(StHtml::Ruing::Elements::Renderers::TextFieldRenderer), 'Renderer wrong.'
    
      tfn = StHtml::Ruing::Elements::TextField.new "myname", :renderer_options => { :option1 => "a", :option2 => "b" }
      assert_not_nil tfn.renderer, 'Renderer not initialized.'
      assert tfn.renderer.is_a?(StHtml::Ruing::Elements::Renderers::TextFieldRenderer), 'Renderer wrong.'
    

      # Factory has same behavior as demonstrated by elements/t00_factory
    end
    
    def test_options
      #
      # No more features to test than default_item
      #
    end

    def test_render_editable
        
      tf = StHtml::Ruing::Elements::TextField.new "myname", :renderer_options => { 
        :builder => StHtml::Ruing::AbstractRenderer.get_builder({ :indent => 0 }),
        :ui_view_factory =>  StHtml::UiViews::Factory 
      }

      tf.value="hello"
      assert_substrings_digroups_cover( [ 
        %-<div-, 
        [%-class="form_item myname"-, 
        %-class="form_item myname"><input-], 
        [%-id="myname_item"-, 
        %-id="myname_item"><input-], 
        [%-type="text"-, 
        %-type="text"/></div>-], 
        [%-class="form_input"-, 
        %-class="form_input"/></div>-], 
        [%-id="myname"-, 
        %-id="myname"/></div>-], 
        [%-name="myname"-, 
        %-name="myname"/></div>-], 
        [%-value="hello"-, 
        %-value="hello"/></div>-] ], 
          tf.renderer.render(tf) )
        
    end
    
    def test_render_not_editable
      
      tf = StHtml::Ruing::Elements::TextField.new "myname", :renderer_options => { 
        :builder => StHtml::Ruing::AbstractRenderer.get_builder({ :indent => 0 }),
        :ui_view_factory =>  StHtml::UiViews::Factory 
      }
      
      tf.value="hello"
      assert_substrings_digroups_cover( [ 
        %-<div-, 
        [%-class="form_item myname"-, 
        %-class="form_item myname"><div-], 
        [%-id="myname_item"-, 
        %-id="myname_item"><div-], 
        [%-class="form_value"-, 
        %-class="form_value">hello</div></div>-], 
        [%-id="myname"-, 
        %-id="myname">hello</div></div>-] ], 
          tf.renderer.render(tf, :editable => false ) )
    end
    
    def test_serializer_initialization
    
      # Same as default_item
    end

    def test_deserialization
        
      # Same as default_item
    end
    def test_under_group_deserialization
        
      # Same as default_item
    end
    
    def test_copying
        
      tf = StHtml::Ruing::Factory.get "text_field", \
              "myname", \
              :option1 => 'a', \
              :renderer_options => { :option2 => 'b' }, \
              :serializer_options => { :option3 => 'c' }
      
      tfc = tf.copy

      # For options is the same of DefaultItem

      assert_not_equal tf.renderer.object_id, tfc.renderer.object_id, 'Copy failed.'
      assert_nil tfc.renderer.options[:option1], 'Copy failed.'
      assert_equal 'b', tfc.renderer.options[:option2], 'Copy failed.'
      assert_nil tfc.renderer.options[:option3], 'Copy failed.'
      
      # For serializer is the same of DefaultItem
    end
    
end

