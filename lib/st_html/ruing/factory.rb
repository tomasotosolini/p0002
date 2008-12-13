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
