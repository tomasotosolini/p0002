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
