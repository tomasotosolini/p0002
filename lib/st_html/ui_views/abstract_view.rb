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

require 'rubygems' 
gem 'builder', '~> 2.0' 

require 'support/util'

module StHtml
module UiViews
    
class AbstractView

    attr :options, true

    def initialize *view_options
        @options = extract_va_options(view_options)
    end


    def render x
        raise StHtml::Exception, 'AbstractView: render method must be overridden.'
    end

    def async_render page, target, x
        page.replace_html(target, render(x)) unless x.nil?
    end

    def AbstractView.builder
        Builder::XmlMarkup.new
    end

end
end
end


