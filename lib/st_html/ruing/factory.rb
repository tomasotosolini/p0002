# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
require 'st_html_license'
require 'st_html'

require 'st_html/ruing/ruing'

module StHtml
module Ruing

class Factory

    def Factory.get type, name, *options

      raise ruing_exception, 'Parameter(s) missing: type, name' \
              unless type && name && !type.strip.empty? && !name.strip.empty?
        
        options = extract_va_options(options)
        folder = options.delete(:elements_folder) 

        if folder 
            begin

                require( "#{folder}/#{type}" )
                klass = "#{type}".camelize
                eval(klass).new name, options
            rescue ::Exception
                get type, name, options
                  #
                  # Removed the folder option, let's try again with safe paths.
            end
        else

            begin
                require( File.join( File.dirname(__FILE__), "elements", type.to_s ) )
                klass = 'StHtml::Ruing::Elements::' + type.to_s.camelize
                eval(klass).new name, options
            rescue ::Exception
                nil
            end

        end
    end
    
end
end
end
