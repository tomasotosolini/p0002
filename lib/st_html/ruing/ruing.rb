
require 'st_html_license'
require 'st_html'

module StHtml
module Ruing

    class Exception < StHtml::Exception; end
        
end
end

module Kernel

    def ruing_exception
       StHtml::Ruing::Exception 
    end
end