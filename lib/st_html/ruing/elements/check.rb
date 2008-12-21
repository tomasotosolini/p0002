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
 
require 'st_html/support/util'
require 'st_html/ruing/elements/default_item'
require 'st_html/ruing/elements/renderers/check_renderer'
require 'st_html/ruing/elements/serializers/check_serializer'
require 'st_html/ui_views/factory'


module StHtml
module Ruing
module Elements

class Check < DefaultItem
    
    def initialize n, *check_options

        co = extract_va_options check_options
        
        #
        # Forcing the renderer as described in TextField
        # 
        # The choice of the ui_view_factory is to defer the choice of the view
        # at the rendering time, since the values of the check will always be 
        # booleans, this will leed to StBooleanView descendants:
        # StFalseClassView or StTrueClassView
        #
        self.renderer= co.delete(:renderer) || 
                StHtml::Ruing::Elements::Renderers::CheckRenderer.new( { \
                        :ui_view_factory => StHtml::UiViews::Factory }.merge( \
                                co.delete(:renderer_options) || {} ) ) 
                
        self.serializer= co.delete(:serializer) ||
                StHtml::Ruing::Elements::Serializers::CheckSerializer.new( \
                    co.delete(:serializer_options) || {} )
        
        super n, co 
    end

    
    def checked?
        return value.nil? ? false : value
    end

    
    def copy
        
        super { |options_|
            
            Check.new "copy_of_#{self.name}", \
                    options_.merge(:renderer_options => self.renderer.options, \
                    :serializer_options => self.serializer.options)
        }
    end
    
end

end
end
end
