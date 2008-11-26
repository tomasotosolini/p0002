
require 'st_html_license'

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
