
require 'st_html_license'

require 'support/util'
require 'st_html/ui_views/abstract_view'

class StDateView < StHtml::UiViews::AbstractView


    def render(x)

       default_format = "%d/%m/%Y"

        return 'Not a Date' if x.nil? || !x.is_a?(Time)
        if self.options.has_key?(:format)
            begin
                return sprintf(self.options[:format], x) + "\n"
            rescue Exception => e
                return x.strftime(default_format) + "\n"
            end
        else
            return x.strftime(default_format) + "\n"
        end
    end

end