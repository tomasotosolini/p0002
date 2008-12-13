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
