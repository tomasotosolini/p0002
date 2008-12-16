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

require 'st_html/ruing/ruing'
require 'st_html/ruing/abstract_item'

class T06_AbstractItem < Test::Unit::TestCase

    def test_abstract_item

        assert_nothing_raised do 
          ai = StHtml::Ruing::AbstractItem.new "myname", :option1 => "a", :option2 => "b"
        end
    end
    
    def test_names

        assert_raise ruing_exception do 
          ai = StHtml::Ruing::AbstractItem.new nil
        end
        assert_raise ruing_exception do 
          ai = StHtml::Ruing::AbstractItem.new ""
        end
        assert_raise ruing_exception do 
          ai = StHtml::Ruing::AbstractItem.new "   "
        end
        assert_nothing_raised do 
          ai = StHtml::Ruing::AbstractItem.new :mysymbol
          assert ai.name.eql?(:mysymbol), 'Wrong name.'
        end
        assert_nothing_raised do 
          ai = StHtml::Ruing::AbstractItem.new 5, :option1 => "a", :option2 => "b"
          assert ai.name.eql?(5), 'Wrong name.'
        end
        assert_nothing_raised do 
            #
            # Objects as names(need only to_s not empty...)
            #
          ai = StHtml::Ruing::AbstractItem.new self.class, :option1 => "a", :option2 => "b"
          assert ai.name.eql?(self.class), 'Wrong name.'
        end
    end


    def test_options
        
        ai = StHtml::Ruing::AbstractItem.new :mysymbol
        assert !ai.options[:force].nil? && ai.options[:force].eql?({}), "Forced options not initialized."
        assert ai.options[:force].eql?(ai.forced_options), "Different access to same thing gives different results."
        assert ai.client_attributes.eql?({}), "Client attributes not empty."
        assert ai.value.nil?, "Value not nil."
        
        ai = StHtml::Ruing::AbstractItem.new :mysymbol, :force => { :someoption => true }, :value => "xyz"
        assert !ai.options[:force].nil? && ai.options[:force][:someoption], "Forced options not set."
        assert ai.client_attributes.eql?({}), "Client attributes not empty."
        assert ai.value.eql?("xyz"), "Value not set."
        ai.client_attributes[:client1]= "something1"
        ai.client_attributes[:client2]= "something2"
        assert ai.client_attributes.has_key?(:client1) , "Client value not set."
        assert ai.client_attributes.has_key?(:client2) , "Client value not set."
    end
    
    def test_ids
        
        ai = StHtml::Ruing::AbstractItem.new :mysymbol
        assert !ai.input_id.nil? && ai.input_id.eql?(:mysymbol.to_s), "Wrong input id."
        assert !ai.item_id.nil? && ai.item_id.eql?(:mysymbol.to_s + "_item"), "Wrong input id."
        
    end
end
