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


    attr :options, true
    attr :name, true
    attr :value, true
    attr :client_attributes, true
      # client_attributes an hash where client may store their informations


    def initialize n, *item_options

        if n.nil? || n.to_s.strip.empty? then 
            raise StHtml::Ruing::Exception, \
                'Item name must be a not empty string or symbol.' 
        end

        @name = n 
        @options = { :force => {} }.merge( extract_va_options( item_options ) )
        @client_attributes = { }

        @value = if @options[:value]
            @options.delete(:value) 
        else
          nil
        end
    end


    def forced_options
        return @options[:force]
    end


    def input_id
        @name.to_s
    end

    def item_id
        return input_id  + "_item"
    end

end

end
end

