
require 'st_html_license'
require 'st_html'

require 'support/util'


module StHtml
module Ruing

class AbstractValidator

    UNKNOWN = -1 # return values
    CORRECT = 0
    WARNING = 1
    WRONG   = 2

        # Validator creation time options
    attr( :options, true )

    attr( :response, true )
    attr( :validation_info, true )


    # we don want that values assigned here are modified for external operations
    def initialize( *opt )
        @options = extract_va_options opt 
        @response = UNKNOWN
        @validation_info = {
            :message => nil,
            :class => [] }
        
    end

    # if not passing a block thi is a useless function
    def validate x
 
        if block_given?
            # il the yield using the self one can setup a message
            yield AbstractValidator, self, x
              #
              # the constant AbstractValidator serves as context
              #
        else
            if @options[:proc] && @options[:proc].is_a?(Proc)
                @options[:proc].call AbstractValidator, self, x
                    # 
                    # il primo valore e' il contesto, serve pe le costanti
            else
                @response= CORRECT
            end

        end
    end

    # let's raise the obligatory flag....
    def force_validation x
        x.options.merge( { :obligatory => true } )
        validate x
        x.options.delete :obligatory
    end

    def cached?
        @options.has_key?(:cache) && @options[:cache]
    end
    def cache( x )
        @options[:cache] = x
    end


    def unknown?
        @response.eql?(UNKNOWN)
    end
    def valid?
        @response.eql?(CORRECT)
    end
    def warning?
        @response.eql?(WARNING)
    end
    def wrong?
        @response.eql?(WRONG)
    end


end
end
end
