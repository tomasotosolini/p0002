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

require 'st_html/ruing/ruing'


module StHtml
module Ruing

module LayoutManager

    def add layout_constraint, item
        abstract_exception
    end

    def remove layout_constraint
        abstract_exception
    end

    def layout *layoutoptions
        abstract_exception
    end

    private
    
    def abstract_exception
        raise StHtml::Ruing::Exception, \
            'The methods in StHtml::Ruing::LayoutManager must be redefined.'
    end
end
end
end
