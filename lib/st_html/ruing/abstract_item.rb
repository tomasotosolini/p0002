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

require 'support/util'

module StHtml
module Ruing

class AbstractItem


    attr( :options, true )
    attr( :forced_options )

    attr( :name,    true )

    attr( :value,   true )


    attr( :client_attributes,    true )
    # client_attributes e' una hash dove e' possibile salvare informazioni arbitrarie.


    def initialize(n, *itemoptions)

        if n.nil? || n.to_s.strip.empty? then 
            raise StHtml::Ruing::Exception, \
                'Item name must be a not empty string or symbol.' 
        end


        @name = n 
        @options = { :force => {} }.merge( extract_va_options( itemoptions ) )
        @client_attributes = { }

        self.value= @options[:value] if @options[:value]


        # we should remove the passed options are saved outside the @options hash
        @options.delete(:value)
    end


    def forced_options
        return @options[:force]
    end


    def has_value?
        if @value.nil? || 
                !@value.is_a?(Hash) || 
                !@value.has_key?(:input) || 
                @value[:input].nil? || 
                @value[:input].to_s.strip.empty?
            return false 
        end

        return true
    end
    def value
        return has_value?  ?  @value[:input]  : nil
    end

    def value=(x)
        @value = { }
        unless x.is_a?(Hash)
            @value[:input] = x 
        else
            x.each do |k,v|
                @value[k] = v
            end
        end
    end


    def raw_value
        return @value
    end
    def raw_value=( x )
        @value = x
    end


    def get_input_id
        @name.to_s
    end

    def get_item_id
        return get_input_id  + "_item"
    end






    def get_input_keys
        return { :input => get_input_id  }
    end

end

end
end

