
require 'st_html_license'
require 'st_html'

require 'builder'

require 'support/util'


module StHtml
module Ruing

class AbstractRenderer
    
    #
    # Options set by the renderer, regardless of the objects it will
    # render. Set at renderer creation
    #
    attr( :options, true )

    #
    # Render options set by wrapper object 
    #
    attr( :render_options, true )
    alias :rro :render_options

    def initialize( *opt )
        @options = extract_va_options opt 
        @final_render_options = nil
    end

    #
    # This is the most important for this class :)
    #
    def render(x, *renderoptions)
        @render_options = extract_va_options(renderoptions) unless @render_options
        build_final_render_options(x)
    end

    # TODO Maybe less visible?
    def has_render_option?(_option)
        build_final_render_options( nil ) unless @final_render_options
        return @final_render_options.has_key?(_option)
    end

    def cached?
        return @options.has_key?(:cache) && !@options[:cache].nil?
    end
    def cache( x )
        @options[:cache] = x
    end

    # this thethod fully replaces the ui element originating from x
    def update(page, x, *renderoptions)

        @render_options = extract_va_options(renderoptions) unless @render_options

        if !x.nil? \
              && x.respond_to?(:items) \
              && x.respond_to?(:renderer) \
              && !x.renderer.nil? \
              && x.renderer.is_a?(AbstractRenderer)

            if x.respond_to?(:items)

                page.replace( x.get_input_id, x.renderer.render(x, @render_options) )
                  # Groups use input instead of item the real operation is done 
                  # by render so here we have only to allow it to receive 
                  # renderoptions
            else

                page.replace( x.get_item_id, x.renderer.render(x, @render_options) )
                  # the real operation is done by render so here we have only 
                  # to allow it to receive renderoptions
            end

        elsif defined? RAILS_DEFAULT_LOGGER then 
            RAILS_DEFAULT_LOGGER.info "St::Html::Ruing::Render::AbstractRenderer:  failed update"
            RAILS_DEFAULT_LOGGER.info "    page=#{page}"
            RAILS_DEFAULT_LOGGER.info "    x=#{x}"
            RAILS_DEFAULT_LOGGER.info "    renderoptions=#{renderoptions}"
        else
            raise 
        end

    end




    #        def update_after_validation(page, x, *renderoptions)
    ##TODO questo metodo deve venire aggiunto da validator togliendo l'interdipendenza
    #            unless x.nil? 
    #    
    #                if x.is_a?(St::Html::Form3::AbstractGroup) &&
    #                        x.respond_to?(:validators) && 
    #                        x.validators && 
    #                        (x.validators.size > 0) && 
    #                        x.validators[0].is_a?(St::Html::Ruing::Validation::AbstractValidator) && 
    #                        ( not x.validators[0].valid? )
    #    
    #                    x.items.each do |item|
    #                        update_after_validation(page, item, *renderoptions)
    #                    end
    #        
    #                elsif x.is_a?(St::Html::Form3::AbstractItem) &&
    #                        x.respond_to?(:validators) && 
    #                        x.validators && 
    #                        (x.validators.size > 0) && 
    #                        x.validators.is_a?(Array) && 
    #                        (x.validators.all? { |v| v.is_a?(St::Html::Ruing::Validation::AbstractValidator)}) &&
    #                        ( some_not_valid?( x.validators ) )
    #    
    #                    ro = St::Html::Support::Util.extract_variable_options(renderoptions) 
    #    
    #                    update(page, x, ro.merge( { 
    #                        :html_options => { 
    #                            :label => {
    #                                :show_error_message => true,
    #                                :error_messages => get_error_messages(x.validators),
    #                                :class => get_classes(x.validators)
    #                            }
    #                        } 
    #                    } ) )
    #    
    #                end
    #    
    #            end
    #    
    #        end

    protected

    # At rendering time, renderer must have a single hash to operate 
    # with, so before the rendering start we must merge in the right
    # order the options set at renderer creation with the onen given 
    # later.
    attr( :final_render_options )
    alias :rfro :final_render_options

    # optimization: scrivendo e leggendo qui si evita di accedere 
    # attraverso la has che sara un po piu lenta
    attr( :rbuilder, true )
    alias :rb :rbuilder 

    def self.get_builder( *bo )
        Builder::XmlMarkup.new( { :indent => 4 }.merge(extract_va_options( bo )) )
    end

    # resolution order for rendering options most important come later
    #   1. Render option of the element to be rendered
    #      -> x.options[:render]
    #   2. Renderer options -> self.options
    #   3. Renderer's render method renderoptions parameter 
    #       -> renderoptions* (after extraction)
    #   4. Render forced_option of the element to be rendered 
    #       -> self.forced_options[:render]
    #
    def build_final_render_options(x)

        return if self.cached?  

        if !x.nil? && x.respond_to?(:options) && x.respond_to?(:forced_options)
            renderee_render_options = x.options[:render] ? x.options[:render] : {}
            renderee_render_force_options = x.forced_options[:render] ? x.forced_options[:render] : {}
        else
            renderee_render_options = {}
            renderee_render_force_options = {}
        end
        renderer_render_options = options || {}
        renderer_render_method_ro_parameter = @render_options || {} 

        @final_render_options = renderee_render_options.merge(
            renderer_render_options.merge(
                renderer_render_method_ro_parameter.merge( renderee_render_force_options )
            ) 
        )

    end

    private

    #            def some_not_valid?(validators_list)
    #                rv = false
    #                validators_list.each do |v|
    #                    rv = rv || (not v.valid?)
    #                end
    #                return rv
    #            end

    #            def get_error_messages(validators_list)
    #                rv = []
    #                validators_list.each do |v|
    #                    rv << v.validation_info[:message] unless rv.include?(v.validation_info[:message])
    #                end
    #                return rv
    #            end

    #            def get_classes(validators_list)
    #                rv = []
    #                validators_list.each do |v|
    #                    rv = rv | v.validation_info[:class]
    #                end
    #                return rv
    #            end
end
end
end











