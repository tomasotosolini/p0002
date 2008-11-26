
require 'st_html_license'

require 'support/util'

require("st/html/ui_views/types/st_string_view")


class StNilClassView < StStringView

	def initialize(*_options)
		super( {
			:empty_nil => true
		}.merge( extract_va_options(_options) ) )

	end

	def render(x)
		return  (@options[:empty_nil] ? "" : "(missing)") + "\n"

	end

end


