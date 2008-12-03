
require 'st_html_license'

require 'st_html/ruing/ruing'

module StHtml
module Ruing
module Elements

module Copyable

    #
    # Copy contructor
    #
    def copy
        
        raise StHtml::Ruing::Exception, \
                "Client class must reimplement this method: copy"
    end
end

end
end
end
