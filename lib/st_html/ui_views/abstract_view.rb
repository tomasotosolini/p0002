
require 'st_html_license'

require 'rubygems' 
gem 'builder', '~> 2.0' 

require 'support/util'

module StHtml
module UiViews
    
class AbstractView

    attr( :options, true)

    def initialize(*_options)
        @options = extract_va_options(_options)
    end


    def render(x)
        raise StHtml::Exception, 'AbstractView: render method must be overridden.'
    end

    def async_render(page, target, x)
        page.replace_html(target, render(x)) unless x.nil?
    end

    def self.builder
        return Builder::XmlMarkup.new
    end

end
end
end


