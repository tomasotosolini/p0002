
require 'st_html_license'

require 'support/util'

module StHtml
module Ruing

class AbstractItem
    
    PATH_SEP = '.'

    attr( :options, true )
    attr( :forced_options )

    attr( :name,    true )
    attr( :parent,   true )

    attr( :value,   true )


    attr( :client_attributes,    true )
        # client_attributes e' una hash dove e' possibile salvare informazioni arbitrarie.


    def initialize(n, *itemoptions)

        @name = n
        @parent = nil
        @options = { :label => nil, :description => nil, :force => {} }.merge( extract_va_options( itemoptions ) )
        @client_attributes = { }

        self.value= @options[:value] if @options[:value]


            # we should remove the passed options are saved outside the @options hash
        @options.delete(:value)

        self.parent_chain!
    end

    def has_label?
        #
        #
        # We can only distinguish nil or not, since labels can be also objects,
        # provided user gives an adequate label view renderer.
        #

        return !@options[:label].nil?
    end
    def label
        return @options[:label]
    end

    def forced_options
        return @options[:force]
    end



    def has_description?
        return !(description.nil? || description.to_s.strip.empty?)
    end
    def description
        return @options[:description]
    end





    def has_name?
        return !(@name.nil? || @name.empty? || @name.strip.empty?)
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
        if @parent
            return parent_path + St::Html::Form3::PATH_SEP + @name.to_s
        else 
            return @name.to_s
        end
    end

    def get_label_id
        return get_input_id  + "_label"
    end

    def get_item_id
        return get_input_id  + "_item"
    end






    def get_input_keys
        return { :input => get_input_id  }
    end

    def added_in(object)
        @parent = object
        self.parent_chain!
    end






    def parent_chain
        if !defined?(@parent_chain) || @parent_chain.nil?
            return parent_chain!
        end
        return @parent_chain
    end
    def parent_chain!
        @parent_chain = if @parent 
            @parent.parent_chain!
            @parent.parent_chain.push(@parent.name) 
        else 
            [] 
        end
        return @parent_chain
    end
    def parent_path
        return parent_chain.join(PATH_SEP)
    end

    def top_parent
        return @parent ? @parent.top_parent : self
    end

end
    
end
end

