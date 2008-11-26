
require 'st_html_license'

require 'st_html'
require 'support/util'
require 'st_html/ui_views/abstract_view'

#TODO Class moveout
=begin

This class must go out of here, requres concept on form item and so on
so is best suitable for being postioned elsewhere
 
=end

class ActionsView < StHtml::UiViews::AbstractView


    def render(x)

        url = x.options[:url] ? x.options[:url] : ( x.controller ? [x.controller, "action_performed" ].join("/") : "action_performed" ) 
    
        parameters_to_json = x.parameters.to_json.gsub("\"", "'")

        _builder = ActionsView.builder

        onclick = x.options[:onclick] ? "#{x.options[:onclick]}; " : ""
        onclick += %@new Ajax.Request('#{url}', {asynchronous:true, evalScripts:true, parameters:$H(#{parameters_to_json}).toQueryString() }); return false;@

        _builder.a(
                :class => :action, 
                :href => "javascript: void(0);", 
                :onclick => onclick, 
                :id => x.action_id, :alt => x.options[:label] ? x.options[:label].to_s : x.name.to_s ) { |_builder_|

            if x.options[:image]
                _builder_.img(
                    :alt => x.options[:label] ? x.options[:label].to_s : x.name.to_s,
                    :src => x.options[:image].to_s )
            else
                _builder_.target! << ( x.options[:label] ? x.options[:label].to_s : x.name.to_s )
            end
        
        }

	return _builder.target!
  end



end



