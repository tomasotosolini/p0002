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


class T03bis_Factory < Test::Unit::TestCase

    def test_selection

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

    
    def test_folders
        
        e = StHtml::Ruing::Factory.get "my_new_kind_of_element", \
                "mytextfield", \
                :elements_folder => \
                    File.join(File.dirname(__FILE__), 'my_elements_folder')
            
        assert e.is_a?(::MyNewKindOfElement), 'Wrong returned type.'
    end
   
end
