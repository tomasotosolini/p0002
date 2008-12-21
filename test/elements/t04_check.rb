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
require 'st_html/ruing/elements/check.rb'
require 'st_html/ruing/factory.rb'


class T04_Check < Test::Unit::TestCase

    include TestElement

    def test_creation

        assert_nothing_raised do 
          cn = StHtml::Ruing::Elements::Check.new "myname"
        end
        assert_nothing_raised do
          cf = StHtml::Ruing::Factory.get "check", "myname"
        end
    
        cn = StHtml::Ruing::Elements::Check.new "myname"
        cf = StHtml::Ruing::Factory.get "check", "myname"
        
        assert cn.is_a?(cf.class), 'Initialization equality failure(type).'
        assert_equal cn.name, cf.name, 'Initialization equality failure(name).'
    end
    
    def test_renderer_initialization

      cn = StHtml::Ruing::Elements::Check.new "myname"
      assert_not_nil cn.renderer, 'Renderer not initialized.'
      assert cn.renderer.is_a?(StHtml::Ruing::Elements::Renderers::CheckRenderer), 'Renderer wrong.'
    
      cn = StHtml::Ruing::Elements::Check.new "myname", :renderer => StHtml::Ruing::Elements::Renderers::CheckRenderer.new( :option1 => "a", :option2 => "b" )
      assert_not_nil cn.renderer, 'Renderer not initialized.'
      assert cn.renderer.is_a?(StHtml::Ruing::Elements::Renderers::CheckRenderer), 'Renderer wrong.'
    
      cn = StHtml::Ruing::Elements::Check.new "myname", :renderer_options => { :option1 => "a", :option2 => "b" }
      assert_not_nil cn.renderer, 'Renderer not initialized.'
      assert cn.renderer.is_a?(StHtml::Ruing::Elements::Renderers::CheckRenderer), 'Renderer wrong.'
    
      # Factory has same behavior as demonstrated by elements/t00_factory
    end
    
    def test_options
      #
      # No more features to test than default_item
      #
    end
    
    def test_render_editable
  
      cf = StHtml::Ruing::Factory.get "check", "myname", :renderer_options => { 
        :builder => StHtml::Ruing::AbstractRenderer.get_builder({ :indent => 0 })
      }

      cf.value= true
      assert_substrings_digroups_cover( [ 
        %-<div-, 
        [%-class="form_item myname"-, 
          %-class="form_item myname"><input-], 
        [%-id="myname_item"-, 
          %-id="myname_item"><input-], 
        [%-type="checkbox"-, 
          %-type="checkbox"/></div>-], 
        [%-class="form_input"-, 
          %-class="form_input"/></div>-], 
        [%-id="myname"-, 
          %-id="myname"/></div>-], 
        [%-name="myname"-, 
          %-name="myname"/></div>-], 
        [%-checked="true"-, 
          %-checked="true"/></div>-] ], 
          cf.renderer.render(cf) )
        
    end
    
    def test_render_not_editable
      
      cf = StHtml::Ruing::Factory.get "check", "myname", :renderer_options => { 
        :builder => StHtml::Ruing::AbstractRenderer.get_builder({ :indent => 0 })
      }
      
      cf.value=true
      assert_substrings_digroups_cover( [ 
        %-<div-, 
        [%-class="form_item myname"-, 
          %-class="form_item myname"><div- ], 
        [%-id="myname_item"-, 
          %-id="myname_item"><div-], 
        [%-class="form_value"-, 
          %-class="form_value">True</div></div>-], 
        [%-id="myname"-, 
          %-id="myname">True</div></div>-], 
        ], 
          cf.renderer.render(cf, :editable => false ) )
    end

    def test_serializer_initialization
    
      c = StHtml::Ruing::Elements::Check.new "myname"
      assert_not_nil c.serializer, 'Serializer not initialized.'
      assert c.serializer.is_a?(StHtml::Ruing::Elements::Serializers::CheckSerializer), 'Serializer wrong.'
      assert_nil c.serializer.options[:option1], 'Serializer wrong.'
    
      c = StHtml::Ruing::Elements::Check.new "myname", 
              :serializer => StHtml::Ruing::Elements::Serializers::CheckSerializer.new( :option1 => "a", :option2 => "b" )
      assert_not_nil c.serializer, 'Serializer not initialized.'
      assert c.serializer.is_a?(StHtml::Ruing::Elements::Serializers::CheckSerializer), 'Serializer wrong.'
      assert_equal 'a', c.serializer.options[:option1], 'Serializer wrong.'
      assert_equal 'b', c.serializer.options[:option2], 'Serializer wrong.'
      assert_nil c.serializer.options[:option3], 'Serializer wrong.'

      c = StHtml::Ruing::Elements::Check.new "myname", :serializer_options => { :option1 => "a", :option2 => "b" }
      assert_not_nil c.serializer, 'Serializer not initialized.'
      assert c.serializer.is_a?(StHtml::Ruing::Elements::Serializers::CheckSerializer), 'Serializer wrong.'
      assert_equal 'a', c.serializer.options[:option1], 'Serializer wrong.'
      assert_equal 'b', c.serializer.options[:option2], 'Serializer wrong.'
      assert_nil c.serializer.options[:option3], 'Serializer wrong.'

      # Factory has same behavior as demonstrated by elements/t00_factory
    end

    # Testing the deserialization after a post/get request, we imagine to get
    # the "params" hash from ActionController
    def test_direct_deseriaziation
        
        cf = StHtml::Ruing::Factory.get "check", "myname"
        
          # HTML checked checkboxes are post in this way: the key is the 
          # name of the control, the value is "on"
        cf.serializer.value_from_params cf, { 'myname' => 'on' }
        
        assert cf.value, 'Wrond de-serialization'
        
        cf.serializer.value_from_params cf, { 'myname' => 'off' } # this is not real, is only to demostarte tha if not on the false
        assert !cf.value, 'Wrond de-serialization'
        cf.serializer.value_from_params cf, { 'other_key1_but_myname' => 'on', 
          'other_key2_but_myname' => 'on' }
        assert !cf.value, 'Wrond de-serialization'
      
    end
    
    def test_under_group_deseriaziation
        
        container = StHtml::Ruing::AbstractContainer.new "mycontainer"
        cf = StHtml::Ruing::Factory.get "check", "myname"
        container.add cf
        
          # HTML checked checkboxes are post in this way: the key is the 
          # name of the control, the value is "on"
        cf.serializer.value_from_params cf, { 'mycontainer.myname' => 'on' }
        
        assert cf.value, 'Wrond de-serialization'
        
        cf.serializer.value_from_params cf, { 'mycontainer.myname' => 'off' } # this is not real, is only to demostarte tha if not on the false
        assert !cf.value, 'Wrond de-serialization'
        cf.serializer.value_from_params cf, { 'mycontainer.other_key1_but_myname' => 'on', 
          'mycontainer.other_key2_but_myname' => 'on', 
          'myname' => 'on'      }
        assert !cf.value, 'Wrond de-serialization'
      
    end
    
    def test_serializer_initialization
    
      cn = StHtml::Ruing::Elements::Check.new "myname"
      assert_not_nil cn.serializer, 'Serializer not initialized.'
      assert cn.serializer.is_a?(StHtml::Ruing::Elements::Serializers::CheckSerializer), 'Serializer wrong.'
      assert_nil cn.serializer.options[:option1], 'Serializer wrong.'
    
      cn = StHtml::Ruing::Elements::Check.new "myname", 
              :serializer => StHtml::Ruing::Elements::Serializers::CheckSerializer.new( :option1 => "a", :option2 => "b" )
      assert_not_nil cn.serializer, 'Serializer not initialized.'
      assert cn.serializer.is_a?(StHtml::Ruing::Elements::Serializers::CheckSerializer), 'Serializer wrong.'
      assert_equal 'a', cn.serializer.options[:option1], 'Serializer wrong.'
      assert_equal 'b', cn.serializer.options[:option2], 'Serializer wrong.'
      assert_nil cn.serializer.options[:option3], 'Serializer wrong.'

      cn = StHtml::Ruing::Elements::Check.new "myname", :serializer_options => { :option1 => "a", :option2 => "b" }
      assert_not_nil cn.serializer, 'Serializer not initialized.'
      assert cn.serializer.is_a?(StHtml::Ruing::Elements::Serializers::CheckSerializer), 'Serializer wrong.'
      assert_equal 'a', cn.serializer.options[:option1], 'Serializer wrong.'
      assert_equal 'b', cn.serializer.options[:option2], 'Serializer wrong.'
      assert_nil cn.serializer.options[:option3], 'Serializer wrong.'

      # Factory has same behavior as demonstrated by elements/t00_factory
    end

    def test_deserialization
        
        c = StHtml::Ruing::Factory.get "check", "myname"
        
        c.serializer.value_from_params c, { 'myname' => 'on' }
        assert c.value, 'Wrond de-serialization'
        
        c.serializer.value_from_params c, { 'myname' => 'whatever' }
        assert !c.value, 'Wrond de-serialization'
        c.serializer.value_from_params c, { 'myname' => nil }
        assert !c.value, 'Wrond de-serialization'
        c.serializer.value_from_params c, {  }
        assert !c.value, 'Wrond de-serialization'
    end
    def test_under_group_deserialization
        
        container = StHtml::Ruing::AbstractContainer.new "mycontainer"
        c = StHtml::Ruing::Factory.get "check", "myname"
        container.add c
        
        c.serializer.value_from_params c, { 'mycontainer.myname' => 'on' }
        assert c.value, 'Wrond de-serialization'
        
        c.serializer.value_from_params c, { 'myname' => 'whatever' }
        assert !c.value, 'Wrond de-serialization'
        c.serializer.value_from_params c, { 'myname' => nil }
        assert !c.value, 'Wrond de-serialization'
        c.serializer.value_from_params c, {  }
        assert !c.value, 'Wrond de-serialization'
    end
    
    def test_copying
        
      c = StHtml::Ruing::Factory.get "check", \
              "myname", \
              :option1 => 'a', \
              :renderer_options => { :option2 => 'b' }, \
              :serializer_options => { :option3 => 'c' }
      
      cc = c.copy

      assert_equal 'copy_of_myname', cc.name, 'Copy failed.'
      assert_equal 'a', cc.options[:option1], 'Copy failed.'
      assert_nil cc.options[:option2], 'Copy failed.'
      assert_nil cc.options[:option3], 'Copy failed.'
      assert_not_equal c.renderer.object_id, cc.renderer.object_id, 'Copy failed.'
      assert_nil cc.renderer.options[:option1], 'Copy failed.'
      assert_equal 'b', cc.renderer.options[:option2], 'Copy failed.'
      assert_nil cc.renderer.options[:option3], 'Copy failed.'
      assert_not_equal c.serializer.object_id, cc.serializer.object_id, 'Copy failed.'
      assert_nil cc.serializer.options[:option1], 'Copy failed.'
      assert_nil cc.serializer.options[:option2], 'Copy failed.'
      assert_equal 'c', cc.serializer.options[:option3], 'Copy failed.'
    end
    
end
