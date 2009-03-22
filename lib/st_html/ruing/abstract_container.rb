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
require 'st_html/support/util' 
require 'st_html/ruing/containers/behaviors' 


module StHtml
module Ruing

module AbstractContainer 

    #
    # Setting :transparent => true makes this container act as a simple rendering 
    # container that will have no influence on the name of the contained 
    # elements.
    # 
    # Important note: it's not possible set a container transparent after 
    # creation, because this property determines a behavior of the contained 
    # items, so it would be possible to set transparent also a container that 
    # already contains items, but in the latter case the items aren't updated
    # accordingly. This could be handled resyncing sub-items recoursively but 
    # this would be more complex, so for simplicity we set up thing in this way.
    # Perhaps if needed in the future we will make things more flexible.
    #
    def initialize n, *container_options
        
        super n, { :transparent => false }.merge( 
            extract_va_options(container_options) )

        @items = []
    end

    def transparent?
        self.options[:transparent]
    end

    def items name_or_index=nil
        
        return @items if name_or_index.nil?

          # when receiving an index is easy...
        if name_or_index.is_a? Integer
          return @items[name_or_index]
        end

        for i in 0...@items.size do
            return @items[i] if @items[i].name.eql? name_or_index.to_s
        end
        raise StHtml::Ruing::Exception, \
            "Item not found. #{name_or_index}" 
    end


    def add *new_items
        
        new_items = extract_va_options new_items, false 
        
        new_items.each do |x|
          @items << x
        
          set_parental_relations x
        end  
        new_items.size > 1 ? new_items : new_items[0]
    end

    
    protected
    
    
    def set_parental_relations item

          # making the contained item conscious of its new status
        item.extend Behaviors::Contained
        
          # it is sure that we are father for this object
        item.client_attributes[:parent] = {
            :item => self 
        }
          # perhaps we also are not primordial elements
        item.client_attributes[:parent][:chain] = \
            (client_attributes.has_key?(:parent) ? \
              client_attributes[:parent][:chain] : [] ) + \
                ( transparent? ? [] : [name.to_s] )
              
          # when dealing with containers, let them update their children too
        if item.is_a? AbstractContainer
            item.items.each do |c|
                item.set_parental_relations c
            end
        end
    end
    
    
    def unset_parental_relations item
        
          # removing Contained extensions
        item.extend Behaviors::NotContained
        
          # cut relation with parent
        item.client_attributes[:parent] = {
            :item => nil
        }
          # delete parental relation holder
        item.client_attributes.delete :parent
              
          # when dealing with groups, let them update their children too
        if item.is_a? AbstractContainer
            item.items.each do |c|
                item.set_parental_relations c
            end
        end
    end

    
    public

    
    def remove name_or_index 
        
        # when receiving an index is easy...
      if name_or_index.is_a? Integer
        unset_parental_relations @items[name_or_index]  
        return @items.delete_at( name_or_index ) 
      end
        
        # but also when input is string is not too bad.
      for i in 0...@items.size
        return remove(i) if @items[i].name.to_s.eql? name_or_index.to_s
      end 
      raise StHtml::Ruing::Exception, \
        "Item not found. (#{name_or_index})"
    end

    
    def clear	
        remove(0) while @items.size > 0
    end





    def has_value?
        @items.each do |item|
            return true if item.has_value?  
        end
        false
    end


    def value

        rv = {}
        @items.each do |x|
            rv[x.name] = x.value
        end
        rv
    end

    def value= h 
        raise ruing_exception, \
                "Value must be a not null hash." if !h.nil? && !h.is_a?(Hash)
        if h.nil? then
            self.value= {}
        else
            @items.each do |x|
                if x.is_a?(AbstractContainer)
                    x.value=( h[x.name].nil? ? {} : h[x.name] )
                else
                    x.value= h[x.name] 
                end
            end
        end
    end




    def item_tree
        rv = {}
        @items.each do |x|
            rv[x.name] = x.is_a?(AbstractContainer) ?  x.item_tree : x
        end
        rv
    end

    # ?
    def group_tree
        rv = {}
        @items.each do |x|
            rv[x.name] = x.group_tree if x.is_a?(AbstractContainer)
        end
        rv
    end

    
#    protected
#
#    
#    def raw_items
#        @items
#    end
#    def raw_items= x 
#        @items = x
#    end

end
    
end
end
