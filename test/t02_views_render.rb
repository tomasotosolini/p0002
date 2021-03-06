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

require 'st_html'
require 'st_html/ui_views/factory'
require 'st_html/ui_views/types/st_true_class_view'

class T02_ViewsRender < Test::Unit::TestCase

    def test_render

        v = StHtml::UiViews::Factory.get("string")
        assert(v.render("hello").eql?("hello"), "Expected hello, had #{v.render("hello")}")

        v = StHtml::UiViews::Factory.get("symbol")
        assert(v.render(:hello).eql?("hello"))

        v = StHtml::UiViews::Factory.get("boolean")
        assert(v.render(true).eql?("True"))
        assert(v.render(false).eql?("False"))
        assert(v.render(nil).eql?("False"))
        
        v = StHtml::UiViews::Factory.get("boolean", :use_images => true)
        assert_raise(StHtml::Exception) {
          v.render(true)
        }
        assert_raise(StHtml::Exception) {
          v.render(false)
        }
        
        v = StHtml::UiViews::Factory.get("boolean", :use_images => true, :true_image => "TRUEIMAGE", :false_image => "FALSEIMAGE")
        assert(v.render(true).eql?("TRUEIMAGE"))
        assert(v.render(false).eql?("FALSEIMAGE"))
          #
          # this test tell me that there is a todo....
        
        v = StHtml::UiViews::Factory.get("numeric")
        assert(v.render(5).eql?("5"))
        assert(v.render(5.0).eql?("5.0"))
        assert(v.render(5.9).eql?("5.9"))
        
        v = StHtml::UiViews::Factory.get("my_silly_one", :views_folder => File.join( File.dirname(__FILE__), 'my_views_folder') )
        assert(v.render(nil).eql?("This is a silly view!"))
        
    end
end
