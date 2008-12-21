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
require 'st_html/ruing/elements/hidden.rb'
require 'st_html/ruing/factory.rb'


class T03_Hidden < Test::Unit::TestCase

    include TestElement

    def test_creation

        assert_nothing_raised do 
          hn = StHtml::Ruing::Elements::Hidden.new "myname"
        end
        assert_nothing_raised do
          hf = StHtml::Ruing::Factory.get "hidden", "myname"
        end
    
        hn = StHtml::Ruing::Elements::Hidden.new "myname"
        hf = StHtml::Ruing::Factory.get "hidden", "myname"
        
        assert hn.is_a?(hf.class), 'Initialization equality failure(type).'
        assert_equal hn.name, hf.name, 'Initialization equality failure(name).'
    end
    
    def test_renderer_initialization

      hn = StHtml::Ruing::Elements::Hidden.new "myname"
      assert_not_nil hn.renderer, 'Renderer not initialized.'
      assert hn.renderer.is_a?(StHtml::Ruing::Elements::Renderers::HiddenRenderer), 'Renderer wrong.'
    
      my_renderer = StHtml::Ruing::Elements::Renderers::HiddenRenderer.new :option1 => "a", :option2 => "b" 
      hn = StHtml::Ruing::Elements::Hidden.new "myname", :renderer => my_renderer
      assert_not_nil hn.renderer, 'Renderer not initialized.'
      assert hn.renderer.is_a?(StHtml::Ruing::Elements::Renderers::HiddenRenderer), 'Renderer wrong.'
      assert !hn.renderer.eql?(my_renderer), 'Renderer wrong, expected a forced renderer instead of the passed one.'
    
      hn = StHtml::Ruing::Elements::Hidden.new "myname", :renderer_options => { :option1 => "a", :option2 => "b" }
      assert_not_nil hn.renderer, 'Renderer not initialized.'
      assert hn.renderer.is_a?(StHtml::Ruing::Elements::Renderers::HiddenRenderer), 'Renderer wrong.'
      assert_nil hn.renderer.options[:option1], 'Passed renderer options should have been ignored.'
      assert_nil hn.renderer.options[:option2], 'Passed renderer options should have been ignored.'
      assert_not_nil hn.renderer.ui_view, 'Expected a forced ui_view.'
      assert hn.renderer.ui_view.options[:empty_nil], 'Expected empty_nil option true.'
    
      # Factory has same behavior as demonstrated by elements/t00_factory
    end
    
    def test_options
      #
      # No more features to test than default_item
      #
    end
    
    def test_render_editable
        
      hf = StHtml::Ruing::Factory.get "hidden", "myname"

      hf.value="hello"
      assert_substrings_digroups_cover( [ 
        %-<input-, 
        [%-type="hidden"-, 
        %-type="hidden"/>-], 
        [%-id="myname"-, 
        %-id="myname"/>-], 
        [%-name="myname"-, 
        %-name="myname"/>-], 
        [%-value="hello"-, 
        %-value="hello"/>-] ], 
          hf.renderer.render(hf) )
        
    end
    
    def test_render_not_editable
      
      hf = StHtml::Ruing::Factory.get "hidden", "myname"
      
      hf.value="hello"
      assert_equal( %--, hf.renderer.render(hf, :editable => false ) )
        #
        # It's hidden honey!
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
        
      h = StHtml::Ruing::Factory.get "hidden", \
              "myname", \
              :option1 => 'a', \
              :renderer_options => { :option2 => 'b' }, \
              :serializer_options => { :option3 => 'c' }
      
      hc = h.copy

      # For options is the same of DefaultItem

      # For options is more restricted then default because forces a fixed "renderer"

      # For serializer is the same of DefaultItem

    end
    
end
