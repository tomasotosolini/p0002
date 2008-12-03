# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
require 'test/unit'

require 'st_html/ruing/abstract_validator'

class Validee
    attr :options
    def forced_options
        options[:force]
    end
    def initialize *opt
        
      @options = { :force => {} }.merge( extract_va_options( opt ) )
    end
end

class T05_AbstractValidator < Test::Unit::TestCase

    def test_abstract_validator
        
        av = StHtml::Ruing::AbstractValidator.new :option1 => "a", :option2 => "b"
        assert_not_nil av.options
        assert_equal "a", av.options[:option1]

    end
    
    
end
