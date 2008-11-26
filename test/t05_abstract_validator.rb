# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

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

        assert_nil av.validation_options
        assert_nil av.send( :final_validation_options ) # sometimes rules are there only to be forced :)
        
        av.validate nil, :voption1 => "c" 
        assert_not_nil av.validation_options
        assert_equal "c", av.validation_options[:voption1]
        assert_not_nil av.send( :final_validation_options )
        assert_equal "c", av.send( :final_validation_options )[:voption1]

    end
    
    def test_validation_options_hierarchy

        #
        # we expect validee forced render options
        #
        x = Validee.new :validate => { :option => "validee option" }, \
            :force => { :validate => { :option => "validee forced option" } }
        av = StHtml::Ruing::AbstractValidator.new :option => "validator option"

        av.validate x, :option => "validator validateoption"
        assert_equal "validee forced option", av.send( :final_validation_options )[:option]

        return 
        
        #
        # we expect validator validateoptions
        #
        x = Validee.new :validate => { :option => "validee option" } 
        av = StHtml::Ruing::AbstractValidator.new :option => "validator option"

        av.validate x, :option => "validator validateoption"
        assert_equal "validator validateoption", av.send( :final_validation_options )[:option]

        
        #
        # we expect validator options
        #
        x = Validee.new :validate => { :option => "validee option" } 
        av = StHtml::Ruing::AbstractValidator.new :option => "validator option"

        av.validate x
        assert_equal "validator option", av.send( :final_validation_options )[:option]

        
        #
        # we expect validee validate options
        #
        x = Validee.new :validate => { :option => "validee option" } 
        av = StHtml::Ruing::AbstractValidator.new 

        av.validate x
        assert_equal "validee option", av.send( :final_validation_options )[:option]
    end
    
    def test_validator_result
        
        #
        # we expect correct, without block or Proc
        #
        x = Validee.new :validate => { :option => "validee option" }, \
            :force => { :validate => { :option => "validee forced option" } }
        av = StHtml::Ruing::AbstractValidator.new :option => "validator option"
        
        av.validate x, :option => "validator validateoption"
        assert_equal StHtml::Ruing::AbstractValidator::CORRECT,  av.response
        
        #
        # we expect correct, with block 
        #
        x = Validee.new :validate => { :option => "validee option" }, \
            :force => { :validate => { :option => "validee forced option" } }
        av = StHtml::Ruing::AbstractValidator.new :option => "validator option"
        
        av.validate x, :option => "validator validateoption" do |ctx, vr, vd|
            vr.response= ctx::CORRECT
        end
        assert_equal StHtml::Ruing::AbstractValidator::CORRECT,  av.response
        
        #
        # we expect wrong, with block 
        #
        x = Validee.new :validate => { :option => "validee option" }, \
            :force => { :validate => { :option => "validee forced option" } }
        av = StHtml::Ruing::AbstractValidator.new :option => "validator option"
        
        av.validate x, :option => "validator validateoption" do |ctx, vr, vd|
            vr.response= ctx::WRONG
        end
        assert_equal StHtml::Ruing::AbstractValidator::WRONG,  av.response
        
        #
        # we expect UNKNOWN, with Proc
        #
        x = Validee.new :validate => { :option => "validee option" }, \
            :force => { :validate => { :option => "validee forced option" } }
        av = StHtml::Ruing::AbstractValidator.new :option => "validator option"

        av.validate x, :option => "validator validateoption", \
            :proc =>  Proc.new { |ctx, vr, vd| \
                        vr.response= ctx::UNKNOWN }

        assert_equal StHtml::Ruing::AbstractValidator::UNKNOWN,  av.response
        
    end
    
end
