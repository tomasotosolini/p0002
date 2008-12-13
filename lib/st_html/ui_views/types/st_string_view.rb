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

class StStringView < StHtml::UiViews::AbstractView


    def initialize(*_options)
        
        super( {
                :prefix => "",
                :empty_nil => false,
                :new_line => false,
        }.merge( extract_va_options(_options) ) )
    end


    def render(x)
      if x.nil? then
        @options[:empty_nil] ? "" : "nil"
      else
        @options[:prefix].to_s + x.to_s + (@options[:new_line] ? "\n" : "")
      end  
    end
end


