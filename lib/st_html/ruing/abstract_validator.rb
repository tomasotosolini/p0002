
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

    attr( :validation_options, true )
    alias :vvo :validation_options
        # optimization: questa viene settata all'inizio
        # forced dell oggetto wrapped

    # we don want that values assigned here are modified for external operations
    def initialize( *opt )
        @options = extract_va_options opt 
        @response = UNKNOWN
        @validation_info = {
            :message => nil,
            :class => [] }
        
        @local_validation_options = nil
    end

    # if not passing a block thi is a useless function
    def validate(x, *validationoptions)
 
        @validation_options = extract_va_options( validationoptions ) unless @validation_options
        build_final_validation_options(x)
        
        if block_given?
            # il the yield using the self one can setup a message
            yield(AbstractValidator, self, x)
              #
              # the constant AbstractValidator serves as context
              #
        else
            if self.vfvo[:proc] && self.vfvo[:proc].is_a?(Proc)
                self.vfvo[:proc].call(AbstractValidator, self, x)
                    # 
                    # il primo valore e' il contesto, serve pe le costanti
            else
                self.response= CORRECT
            end

        end
    end

    # let's raise the obligatory flag....
    def force_validation(x, *validationoptions)
        validate(x, extract_va_options( validationoptions ).merge( { :obligatory => true } ))
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


    protected

    attr( :final_validation_options, true )
    alias :vfvo :final_validation_options 
        # quandi si esegue il validationing bisogna mergare le opzioni local 
        # con quelle passate in fase di rendering, con quello 
        # forced dell oggetto wrapped


    def build_final_validation_options(x)

        return if self.cached?  

        if !x.nil? && x.respond_to?(:options) && x.respond_to?(:forced_options) then

            validee_validation_options = x.options[:validate] ? x.options[:validate] : {}
            validee_validation_force_options = x.forced_options[:validate] ? x.forced_options[:validate] : {}
        else
            validee_validation_options = {}
            validee_validation_force_options = {}
        end
        validator_validation_options = options || {}
        validator_validate_method_vo_parameter = @validation_options || {}

        @final_validation_options = validee_validation_options.merge(
            validator_validation_options.merge(
                validator_validate_method_vo_parameter.merge( validee_validation_force_options )
            ) 
        )

    end

end
end
end
