
require 'st_html_license'

require 'support/util'

require 'st_html/ui_views/types/st_string_view'
  #
  # Used for fallback views

require 'rubygems'
gem 'activesupport'

require 'active_support'
    #
    # Camelization is in our hearts
    
  
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
            rescue ::Exception
                return get(type, opt) 
                      #
                      # Removed the folder option, let's try again with safe paths.
            end
        else

            begin
                require( File.join( File.dirname(__FILE__), "types","st_#{type}_view" ) )
                klass = "st_#{type}_view".camelize
                return eval( klass ).new(opt)
            rescue ::Exception
                return StStringView.new(opt.merge({:prefix => "(FBACK.VIEW for #{type}) "}))
            end

        end
    end

end
end
end

