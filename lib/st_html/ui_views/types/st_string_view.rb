
require 'st_html_license'

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


