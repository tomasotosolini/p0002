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
require 'st_html/ruing/abstract_renderer'

#
# We need an element that supports the concept of options and forced_options
#
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

        assert_not_nil ar.options, 'Expected renderer options to be set.'
        assert_equal "a", ar.options[:option1], 'Wrong renderer option value.'
        assert_nil ar.ro, 'Expected renderer render_options to be empty.'
        assert_nil ar.send( :fro ), 'Expected renderer final_render_options to be empty.' # sometimes rule are there only to be force :)
        
        #
        # This also initializes the other options
        #
        ar.render nil, :roption1 => "c" 
        
        assert_not_nil ar.ro, 'Expected renderer render_options to be not empty.'
        assert_equal "c", ar.ro[:roption1], 'Wrong renderer render_option value.'
        assert_not_nil ar.send( :fro ), 'Expected renderer final_render_options to be not empty.'
        assert_equal "c", ar.send( :fro )[:roption1], 'Wrong renderer final_render_option value.'
    end
    
    def test_render_options_hierarchy
        #
        # This test inteds to demostrate the priority
        # when the same option is given
        #
        
        
        #
        # we expect rendereee forced render options - highest priority
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
        # we expect renderee render options - lowest priority
        #
        x = Renderee.new :render => { :option => "renderee option" } 
        ar = StHtml::Ruing::AbstractRenderer.new 

        ar.render x
        assert_equal "renderee option", ar.send( :fro )[:option]
    end
    
end
