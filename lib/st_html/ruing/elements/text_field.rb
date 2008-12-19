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

    def initialize n, *textfield_options

        tfo = extract_va_options textfield_options
        
        #
        # The idea here is to force a specific renderer for this component, 
        # unless clients do not supply one by themselves using the :renderer 
        # option.
        # 
        # NOTE: we do not check if the renderer supplied by client is really a 
        # text field renderer because if this is not so it is a client's choice
        # (we also hope a conscious one). A similar mechanism is found also 
        # in other DefaultItem's descendants
        #
        self.renderer= tfo.delete(:renderer) || 
                StHtml::Ruing::Elements::Renderers::TextFieldRenderer.new( { \
                        :ui_view_factory => StHtml::UiViews::Factory }.merge( \
                                tfo.delete(:renderer_options) || {} ) ) 
        
        # Uses the same serializer of the DefaultItem
        
        super n, tfo 
    end

end
    
end
end
end
