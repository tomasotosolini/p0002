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
require 'st_html/ruing/factory'
require 'st_html/ruing/elements/default_item.rb'


class T01_DefaultItem < Test::Unit::TestCase

    include TestElement
    
    def test_creation

        assert_nothing_raised do 
          StHtml::Ruing::Elements::DefaultItem.new "myname"
        end
        assert_nothing_raised do
          StHtml::Ruing::Factory.get "default_item", "myname"
        end
        
        din = StHtml::Ruing::Elements::DefaultItem.new "myname"
        dif = StHtml::Ruing::Factory.get "default_item", "myname"
        
        assert din.is_a?(dif.class), 'Initialization equality failure(type).'
        assert_equal din.name, dif.name, 'Initialization equality failure(name).'
    end

    
    def test_renderer_initialization
    
      din = StHtml::Ruing::Elements::DefaultItem.new "myname"
      assert_not_nil din.renderer, 'Renderer not initialized.'
      assert din.renderer.is_a?(StHtml::Ruing::Elements::Renderers::DefaultItemRenderer), 'Renderer wrong.'
    
      din = StHtml::Ruing::Elements::DefaultItem.new "myname", :renderer => StHtml::Ruing::Elements::Renderers::DefaultItemRenderer.new( :option1 => "a", :option2 => "b" )
      assert_not_nil din.renderer, 'Renderer not initialized.'
      assert din.renderer.is_a?(StHtml::Ruing::Elements::Renderers::DefaultItemRenderer), 'Renderer wrong.'
    
      din = StHtml::Ruing::Elements::DefaultItem.new "myname", :renderer_options => { :option1 => "a", :option2 => "b" }
      assert_not_nil din.renderer, 'Renderer not initialized.'
      assert din.renderer.is_a?(StHtml::Ruing::Elements::Renderers::DefaultItemRenderer), 'Renderer wrong.'
    

      # Factory has same behavior as demonstrated by elements/t00_factory
    end

    
    def test_options
      
      # No option is given, use the dafults
      din = StHtml::Ruing::Elements::DefaultItem.new "myname"
      assert_equal({}, din.options[:render], 'Wrong initialization.')
      assert_equal({}, din.options[:force][:render], 'Wrong initialization.')
      assert_equal nil, din.value, 'Wrong initialization.'
      
      # Testin with options
      din = StHtml::Ruing::Elements::DefaultItem.new "myname", \
              :value => 'v1', \
              :option1 => 'v2', \
              :render => { 
                :option1 => 'v3' }, \
              :force => { \
                  :option1 => 'v4', \
                  :render => { 
                    :option1 => 'v5' }
                    },
               :renderer_options => { :option1 => 'v6' }
              
      assert_equal 'v2', din.options[:option1], 'Wrong parameter routing.'
      assert_equal 'v3', din.options[:render][:option1], 'Wrong parameter routing.'
      # This option is here and is correctly routed bu will have no meaning,
      # only to test the mechanism in abstract
      assert_equal 'v4', din.options[:force][:option1], 'Wrong parameter routing.' 
      assert_equal 'v5', din.options[:force][:render][:option1], 'Wrong parameter routing.'
      assert_equal 'v1', din.value, 'Wrong parameter routing.'
      # This must be nil because went to initiatialize the renderer
      assert_nil din.options[:renderer_options], 'Wrong parameter routing.'
      assert_equal 'v6', din.renderer.options[:option1], 'Wrong parameter routing.'
      
    end
    
    
    
    def test_render_editable

      di = StHtml::Ruing::Elements::DefaultItem.new "myname", :renderer_options => { 
        :builder => StHtml::Ruing::AbstractRenderer.get_builder({ :indent => 0 }),
        :ui_view_factory =>  StHtml::UiViews::Factory 
      }

      di.value="hello"
      assert_substrings_cover( [ 
              %-<div-, 
              %-class="form_item myname"-, 
              %-class="form_item myname"></div>-, 
              %-id="myname_item"-, 
              %-id="myname_item"></div>- ], 
          di.renderer.render(di) )
        
    end
    
    def test_render_not_editable

      di = StHtml::Ruing::Elements::DefaultItem.new "myname", :renderer_options => { 
        :builder => StHtml::Ruing::AbstractRenderer.get_builder({ :indent => 0 }),
        :ui_view_factory =>  StHtml::UiViews::Factory 
      }

      di.value="hello"
      assert_substrings_cover( [ 
              %-<div-, 
              %-class="form_item myname"-, 
              %-class="form_item myname"><div-, 
              %-id="myname_item"-,
              %-id="myname_item"><div-,
              %-class="form_value"-,
              %-class="form_value">hello</div></div>-,
              %-id="myname"-,
              %-id="myname">hello</div></div>- ], 
        di.renderer.render(di, :editable => false ), 'Wrong rendering.')

    end

    # This is special for default_item so we need another small test.
    # Will also be inherited by descendant classes.
    def test_item_direct_methods

      di = StHtml::Ruing::Elements::DefaultItem.new "myname"

      assert_equal( di.renderer.render(di), di.render, 'Wrong direct rendering.')
      assert_equal( di.renderer.render(di, :editable => false), di.render_, 'Wrong direct rendering.')

    end
    
end
