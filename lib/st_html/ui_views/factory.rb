
require 'st_html_license'

require 'rubygems'
gem 'activesupport'

require 'active_support'
    #
    # Camelization is in our hearts
    
require 'support/util'

module StHtml
module UiViews
    
class Factory

    def self.get(type, *options)
        
        opt = extract_va_options(options)
        views_folder = opt.delete(:views_folder)

        if views_folder

            begin
                require( "#{views_folder}/#{type}_view" )
                klass = "#{type}_view".camelize
                return eval( klass ).new(opt)
            rescue Exception => exc
                return self.get(type, opt) 
                  #
                  # Removed the folder option, let's try again with safe paths.
            end

        else

            begin
                require( File.dirname(__FILE__) + "/types/st_#{type}_view" )
                klass = "st_#{type}_view".camelize
                return eval( klass ).new(opt)
            rescue Exception => exc
                require( File.dirname(__FILE__) + "/types/st_string_view" )
                klass = "st_string_view".camelize
                v = eval( klass ).new( {:prefix => "(FBACK.VIEW for #{type}) "} )
                return v
            end

        end
    end

end
end
end

