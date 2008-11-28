############################################################################
##    Copyright (C) 2007 by Stefano Salvador, Tomaso Tosolini                                      
##    <stefano.salvador@cbm.fvg.it, tomaso.tosolini@cbm.fvg.it>                                                             
##
## Copyright: See COPYING file that comes with this distribution
##
############################################################################
#
#require( 'st' )
#require( 'st/html' )
#require( 'st/html/form3' )
#
#require( 'st/html/form3/abstract_item' )
#
#require( 'st/html/form3/exceptions' )
#
#require( 'st/html/support/util' )

module StHtml
module Ruing

# ------------------------------------------------------------------------------    
# When the items become contained, will use this to extend themselves a bit 
module Contained
    
    def Contained.extend_object contained

        if contained.respond_to?(:get_input_id) \
            and !contained.respond_to?(:item_get_input_id) # apply once is enough!

            ec = class << contained; self; end # Catch the eigenclass
            
            ec.class_eval { # Because these methods are private
                
              alias_method :item_get_input_id, :get_input_id  
                #
                # Put in the safe the old method, is still necessary
                
                # This method is now conscious of the parental relationship
              define_method :get_input_id do
                  if client_attributes[:parent]
                    (client_attributes[:parent][:chain] \
                        + [item_get_input_id]).join(StHtml::Ruing::AbstractItem::PATH_SEP)
                  else 
                    item_get_input_id
                  end
              end
              
                # A new method
              define_method :root_parent do
                return client_attributes[:parent] \
                    && client_attributes[:parent][:root] ? \
                    client_attributes[:parent][:root] : contained
              end
              
            }
            super
        else
            raise StHtml::Ruing::Exception, \
              'Extended element must respong to :get_input_id.'
      end
    end
    
end # --------------------------------------------------------------------------   

# ------------------------------------------------------------------------------    
# When no more contained
module NotContained
    
    def NotContained.extend_object contained

        if contained.respond_to?(:get_input_id) \
            and contained.respond_to?(:item_get_input_id) 
              #
              # The latter is required for restoring

            ec = class << contained; self; end # Catch the eigenclass
            
            ec.class_eval { # Because these methods are private
                
              remove_method :get_input_id 
                #
                # Removing enhanced version
                
              remove_method :root_parent 
              
              alias_method :get_input_id, :item_get_input_id
                #
                # Restoring original
            }
            super
        else
            raise StHtml::Ruing::Exception, \
              'Extended element must respong to :get_input_id.'
      end
    end
    
end # --------------------------------------------------------------------------   

class AbstractContainer < AbstractItem

    
    def initialize(n, *container_options)
        
        super n, extract_va_options(container_options)

        @items = []
    end


    def items name_or_index=nil
        return @items if n.nil?

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
        item.extend Contained
        
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
        item.extend NotContained
        
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
