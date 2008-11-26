
require 'st_html_license'

require 'st_html'
require 'support/util'
require 'st_html/ui_views/abstract_view'

class StBooleanView < StHtml::UiViews::AbstractView


    def initialize(*_options)
        
        super( { :use_images => false \
          }.merge( extract_va_options(_options) ) )
    end


    def render(x)
        if @options[:use_images] then
            
            raise StHtml::Exception, 'StBooleanView.render: missing image.' \
              unless @options[:true_image] and @options[:false_image]
            
            return x ? @options[:true_image] : @options[:false_image]  
        else
            return x ? "True" : "False"
        end
    end
end


