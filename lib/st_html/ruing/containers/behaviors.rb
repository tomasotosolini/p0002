
require( 'st_html' )
require( 'st_html_license' )


module StHtml
module Ruing
module Behaviors

module Contained
    
    #
    # When an item is inserted into a container we use this module to extend a bit 
    # the behavior of the item.
    #
    
    PATH_SEP = '.'

    def Contained.extend_object contained

        raise StHtml::Ruing::Exception, \
              'Extended element must respong to :get_input_id.' \
              unless contained.respond_to?(:get_input_id) 
      
        return  if contained.respond_to?(:item_get_input_id) 
          #
          # Apply once is enough!

        ec = class << contained; self; end # Catch the eigenclass
            
        ec.class_eval { # Because these methods are private

            alias_method :item_get_input_id, :get_input_id  
            #
            # Put in the safe the old method, is still necessary

              # This method is now conscious of the parental relationship
            define_method :get_input_id do
                if client_attributes[:parent]
                    (client_attributes[:parent][:chain] \
                    + [item_get_input_id]).join(PATH_SEP)
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
    end
    
end 


module NotContained
    
    #
    # When item is removed from container let's restore it's bahavior
    #
    
    def NotContained.extend_object contained

        raise StHtml::Ruing::Exception, \
            'Extended element must respong to :get_input_id.' \
            unless contained.respond_to?(:get_input_id)  
              #
              # It must at least seem that this is anitem
              
        raise StHtml::Ruing::Exception, \
            'Extended element must respong to :item_get_input_id.' \
            unless contained.respond_to?(:item_get_input_id) 
              #
              # This is needed for restoring

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
    end
    
end 

    
end
end
end
