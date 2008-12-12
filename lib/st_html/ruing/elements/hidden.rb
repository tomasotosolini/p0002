
require 'st_html_license' 
require 'st_html/support/util'
require 'st_html/ruing/elements/default_item'
require 'st_html/ruing/elements/renderers/hidden_renderer'
require 'st_html/ui_views/factory'

module StHtml
module Ruing
module Elements

class Hidden < DefaultItem

    def initialize(n, *hiddenoptions)

        ho = extract_va_options(hiddenoptions)
        
        self.renderer= StHtml::Ruing::Elements::Renderers::HiddenRenderer.new \
                 :ui_view => StHtml::UiViews::Factory.get( 'string', :empty_nil => true ) 
            
        super n, ho 
    end

end

end
end
end
