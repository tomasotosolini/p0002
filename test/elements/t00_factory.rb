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
 

require 'st_html/ruing/factory'
require 'st_html/ruing/elements/text_field'
require 'st_html/ruing/elements/hidden'

#require 'elements/my_elements_folder/my_new_kind_of_element'


class T00_Factory < Test::Unit::TestCase

    def test_selection
        # using text_field and hidden even if not testes extensively yet...
        
        assert_nothing_raised do 
          e = StHtml::Ruing::Factory.get "text_field", "mytextfield"
        end
        assert_raise(ruing_exception) do 
          e = StHtml::Ruing::Factory.get "", ""
        end
        assert_raise(ruing_exception) do 
          e = StHtml::Ruing::Factory.get "", "name"
        end
        assert_raise(ruing_exception) do 
          e = StHtml::Ruing::Factory.get "type", ""
        end
        assert_raise(ruing_exception) do 
          e = StHtml::Ruing::Factory.get " ", " "
        end
        
        e = StHtml::Ruing::Factory.get "text_field", "mytextfield"
        assert e.is_a?(StHtml::Ruing::Elements::TextField), 'Wrong returned type.'
        e = StHtml::Ruing::Factory.get "hidden", "mytextfield"
        assert e.is_a?(StHtml::Ruing::Elements::Hidden), 'Wrong returned type.'
    end

    def test_options
        
        e = StHtml::Ruing::Factory.get "my_new_kind_of_element", \
                "mytextfield", \
                :option1 => { :option2 => 'v1'},
                :option2 => 'v2',
                :elements_folder => \
                    File.join(File.dirname(__FILE__), 'my_elements_folder')

            
        assert_not_nil e.options, 'Wrong option storing.'
        assert_equal 'v1', e.options[:option1][:option2], 'Wrong option storing.'
        assert_equal 'v2', e.options[:option2], 'Wrong option storing.'
        assert_nil e.options[:option3], 'Wrong option storing.'
        assert_nil e.options[:elements_folder], 'Expected that :elements_folder was removed by Factory.'
    end
    
    def test_folders
        
        e = StHtml::Ruing::Factory.get "my_new_kind_of_element", \
                "mytextfield", \
                :elements_folder => \
                    File.join(File.dirname(__FILE__), 'my_elements_folder')
            
        assert e.is_a?(::MyNewKindOfElement), 'Wrong returned type.'
    end
   
end
