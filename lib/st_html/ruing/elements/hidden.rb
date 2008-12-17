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

require 'st_html/support/util'
require 'st_html/ruing/elements/default_item'
require 'st_html/ruing/elements/renderers/hidden_renderer'
require 'st_html/ui_views/factory'


module StHtml
module Ruing
module Elements

class Hidden < DefaultItem

    def initialize n, *hidden_options

        ho = extract_va_options hidden_options
        
        #
        # Forcing the renderer as described in TextField
        #
        # renderer_options are not allowed for hidden, it has only to carry values
        # without more features
        #
        self.renderer= StHtml::Ruing::Elements::Renderers::HiddenRenderer.new( \
                 :ui_view => StHtml::UiViews::Factory.get( 'string', \
                     :empty_nil => true ) )
           
        super n, ho 
    end

end

end
end
end
