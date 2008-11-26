
require 'st_html_license'

require 'support/util'
require 'st_html/ui_views/abstract_view'

class StSymbolView < StHtml::UiViews::AbstractView

    def render(x)
      return  x.nil? ? "" : x.to_s  
    end
end


