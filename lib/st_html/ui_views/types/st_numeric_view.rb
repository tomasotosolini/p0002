
require 'st_html_license'

require 'support/util'
require 'st_html/ui_views/abstract_view'

class StNumericView < StHtml::UiViews::AbstractView


    def initialize(*_options)
        super( {
                :new_line => false,
        }.merge( extract_va_options(_options) ) )

    end


    def render(x)
        return  x.to_s + (@options[:new_line] ? "\n" : "")
    end
end


