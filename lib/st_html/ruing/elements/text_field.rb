#
#require 'st'
#require 'st/html'
#require 'st/html/form3'
#require 'st/html/form3/elements'
#
#
#require 'st/html/support/util'
#
#
#require 'st/html/ui_views/factory'
#
#

require 'st_html/ruing/elements/default_item'
require 'st_html/ruing/elements/renderers/text_field_renderer'

module StHtml
module Ruing
module Elements
        
class TextField < DefaultItem

    def initialize(n, *textfieldoptions)

        tfo = extract_va_options(textfieldoptions)
        
        self.renderer= StHtml::Ruing::Elements::Renderers::TextFieldRenderer.new( 
                { :ui_view_factory => StHtml::UiViews::Factory }.merge( tfo.delete(:renderer_options) || {} ) )
            
        super(n, tfo )

    end

end
    
end
end
end
