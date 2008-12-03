# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
require 'test/unit'


require 'st_html/ui_views/types/st_string_view'
require 'st_html/ui_views/types/st_boolean_view'
require 'st_html/ui_views/types/st_symbol_view'
require 'st_html/ui_views/types/st_true_class_view'
require 'st_html/ui_views/types/st_numeric_view'
require 'test/my_views_folder/my_silly_one_view'
require 'st_html/ui_views/types/actions/actions_view'


require 'st_html/ui_views/factory'

class T01_ViewsFactory < Test::Unit::TestCase

    def test_factory

        v = StHtml::UiViews::Factory.get("what")
        assert(v.is_a?(StStringView))
        assert_not_nil(v.options[:prefix])

        v = StHtml::UiViews::Factory.get("string")
        assert(v.is_a?(StStringView))

        v = StHtml::UiViews::Factory.get("symbol")
        assert(v.is_a?(StSymbolView))

        v = StHtml::UiViews::Factory.get('symbol')
        assert(v.is_a?(StSymbolView))

        v = StHtml::UiViews::Factory.get("boolean")
        assert(v.is_a?(StBooleanView))

        v = StHtml::UiViews::Factory.get("true_class")
        assert(v.is_a?(StTrueClassView))

        v = StHtml::UiViews::Factory.get("numeric")
        assert(v.is_a?(StNumericView))

        v = StHtml::UiViews::Factory.get("my_silly_one", :views_folder => File.join( File.dirname(__FILE__), 'my_views_folder') )
        assert(v.is_a?(MySillyOneView))

        v = StHtml::UiViews::Factory.get("actions", :views_folder => File.join( 'st_html/ui_views/types/actions') )
        assert(v.is_a?(ActionsView))
        
    end
end
