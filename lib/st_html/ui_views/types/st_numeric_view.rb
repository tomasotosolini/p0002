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

require 'support/util'
require 'st_html/ui_views/abstract_view'

class StNumericView < StHtml::UiViews::AbstractView


    def initialize *view_options
        super( {
                :new_line => false,
        }.merge( extract_va_options(view_options) ) )
    end


    def render x
        x.to_s + (@options[:new_line] ? "\n" : "")
    end
end


