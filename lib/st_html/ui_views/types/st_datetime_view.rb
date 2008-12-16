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

class StDatetimeView < StHtml::UiViews::AbstractView


    def render x

    	default_format = "%d/%m/%Y %H:%M:%S"

        return 'Not a Time' if x.nil? || !x.is_a?(Time)
        if options.has_key? :format
            begin
                sprintf(self.options[:format], x) + "\n"
            rescue Exception => e
                x.strftime(default_format) + "\n"
            end
        else
            x.strftime(default_format) + "\n"
        end
    end

end