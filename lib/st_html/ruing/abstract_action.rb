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

require 'st/html/ruing/ruing'

require 'support/util'

module StHtml
module Ruing

module ActionListener

    def action_performed
        action_source = params[:action_source]
        if respond_to?("action_#{action_source}_request")
            rendered = send("action_#{action_source}_request") 
        else
            raise StHtml::Ruing::Exception, \
                "action_extensions: method action_#{action_source}_request " \
                + "not implemented by this controller(#{self.class})."
        end
        render(:nothing => true) unless rendered
    end
end

class AbstractAction

    attr( :name, true )
    attr( :action_id, true )
    attr( :controller, true )
    attr( :parameters, true )

    attr( :options, true )

    # we don want that values assigned here are modified for external operations
    def initialize( name, controller, *opt )
        @options = extract_va_options( opt )

        @name = name
        @action_id = name
            #
            # This is only the default, can be changed if needed
            
        @controller = controller
        @parameters = @options[:parameters] ? @options.delete(:parameters) : {}
        @parameters[:action_source] = @options[:action_source] ? @options.delete(:action_source) : @name
    end

    def copy
        options = @options.merge( { :parameters => copy_easy_hash(self.parameters) } )
        self.class.new @name, @controller, options 
    end

    private 

        # this copies recursively the hash but only if it hasn't objects within...
    def copy_easy_hash(hash)
        rv = {}
        hash.keys.each do |k|
            rv[k] = hash[k].is_a?(Hash) ? copy_easy_hash(hash[k]) : hash[k]
        end
        rv
    end
end

end
end














