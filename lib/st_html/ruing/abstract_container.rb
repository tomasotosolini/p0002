
require( 'st_html' )
require( 'st_html_license' )

require( 'st_html/support/util' )

require( 'st_html/ruing/containers/behaviors' )

module StHtml
module Ruing

class AbstractContainer < AbstractItem

    
    def initialize(n, *container_options)
        
        super n, extract_va_options(container_options)

        @items = []
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


    def add new_item
        @items << new_item
        
        set_parental_relations new_item 
          
        new_item
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
              client_attributes[:parent][:chain] : [] ) + [name.to_s]
              
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
          return @items.delete_at name_or_index 
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
        return false
    end



    def value

        rv = {}
        @items.each do |x|
            rv[x.name] = x.value
        end
        return rv
    end


    def value=( h )
        raise( St::Html::Form3::Exceptions::FormException, "Value must be a not null hash.") if h.nil? || !h.is_a?(Hash)

        @items.each do |x|
            if x.is_a?(AbstractGroup)
                x.value=( h[x.name].nil? ? {} : h[x.name] )
            else
                x.value= h[x.name] 
            end
        end

    end




    def item_tree
        rv = {}
        @items.each do |x|
            rv[x.name] = x.is_a?(AbstractGroup) ?  x.items : x
        end
        return rv
    end

    def group_tree
        rv = {}
        @items.each do |x|
            rv[x.name] = x if x.is_a?(AbstractGroup)
        end
        return rv
    end






protected

    def raw_items
        return @items
    end
    def raw_items=( x )
        @items = x
    end


end
    
end
end
