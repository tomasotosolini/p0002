# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
require 'test/unit'

require 'st_html/ruing/abstract_renderer'

class Renderee
    attr :options
    def forced_options
        options[:force]
    end
    def initialize *opt
        
      @options = { :force => {} }.merge( extract_va_options( opt ) )
    end
end

class T04_AbstractRenderer < Test::Unit::TestCase

    def test_abstract_renderer
        
        ar = StHtml::Ruing::AbstractRenderer.new :option1 => "a", :option2 => "b"
        assert_not_nil ar.options
        assert_equal "a", ar.options[:option1]

        assert_nil ar.ro
        assert_nil ar.send( :fro ) # sometimes rule are there only to be force :)
        
        ar.render nil, :roption1 => "c" 
        assert_not_nil ar.ro
        assert_equal "c", ar.ro[:roption1]
        assert_not_nil ar.send( :fro )
        assert_equal "c", ar.send( :fro )[:roption1]

    end
    
    def test_render_options_hierarchy
        
        #
        # we expect rendereee forced render options
        #
        x = Renderee.new :render => { :option => "renderee option" }, \
            :force => { :render => { :option => "renderee forced option" } }
        ar = StHtml::Ruing::AbstractRenderer.new :option => "renderer option"

        ar.render x, :option => "renderer renderoption"
        assert_equal "renderee forced option", ar.send( :fro )[:option]

        
        #
        # we expect renderer renderoptions
        #
        x = Renderee.new :render => { :option => "renderee option" } 
        ar = StHtml::Ruing::AbstractRenderer.new :option => "renderer option"

        ar.render x, :option => "renderer renderoption"
        assert_equal "renderer renderoption", ar.send( :fro )[:option]

        
        #
        # we expect renderer options
        #
        x = Renderee.new :render => { :option => "renderee option" } 
        ar = StHtml::Ruing::AbstractRenderer.new :option => "renderer option"

        ar.render x
        assert_equal "renderer option", ar.send( :fro )[:option]

        
        #
        # we expect renderee render options
        #
        x = Renderee.new :render => { :option => "renderee option" } 
        ar = StHtml::Ruing::AbstractRenderer.new 

        ar.render x
        assert_equal "renderee option", ar.send( :fro )[:option]
    end
    
end
