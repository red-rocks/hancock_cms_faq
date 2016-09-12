module Hancock::Faq
  module Controllers
    module Questions
      extend ActiveSupport::Concern

      included do
        if Hancock::Faq.config.breadcrumbs_on_rails_support
          add_breadcrumb I18n.t('hancock.breadcrumbs.faq'), :hancock_Faq_faq_path
        end

        helper_method :cache_fields?, :cache_key, :fields_partial, :settings_scope, :hancock_faq_update_captcha_path
      end

      def index
        @questions = question_class.enabled.sorted.to_a
        # index_crumbs
      end

      def show
        @question = question_class.enabled.find(params[:id])
        if !@question.text_slug.blank? and @question.text_slug != params[:id]
          redirect_to hancock_faq_question_path(@question), status_code: 301
          return
        end
        @parent_seo_page = find_seo_page(hancock_faq_question_categories_path) if @seo_page.blank?
        # item_crumbs
      end

      def page_title
        if @question
          @question.page_title
        else
          super
        end
      end

      def create
        @question = question_class.new(question_params)

        if Hancock::Faq.config.captcha
          if Hancock::Faq.config.recaptcha_support
            if verify_recaptcha
              meth = :save
            else
              meth = :valid?
              @recaptcha_error = I18n.t('hancock.errors.faq.recaptcha')
            end

          elsif Hancock::Faq.config.simple_captcha_support
            meth = :save_with_captcha

          else
            meth = :save
          end
        else
          meth = :save
        end

        if @question.send(_method)
          after_create
          if request.xhr? && process_ajax
            ajax_success
          else
            redirect_after_done
          end
        else
          render_faq_error
        end
      end

      def update_captcha
        render layout: false
      end

      def hancock_faq_update_captcha_path
        url_for(action: :update_captcha, time: Time.new.to_i, only_path: true)
      end
      def cache_fields?
        ['new', 'index'].include? action_name
      end
      def cache_key
        'hancock_faq_question_fields'.freeze
      end
      def fields_partial
        "hancock/faq/questions/#{(Hancock::Faq.config.model_settings_support ? 'fields' : 'fields_with_settings')}".freeze
      end
      def settings_scope
        if Hancock::Faq.config.model_settings_support
          question_class.settings
        elsif defined?(Settings)
          Settings.ns('FAQ')
        else
          nil
        end
      end

      private
      def render_faq_error
        if request.xhr? && process_ajax
          render partial: form_partial, status: 422
          # render json: {errors: @contact_message.errors}, status: 422
        else
          flash.now[:alert] = @question.errors.full_messages.join("\n")
          render action: Hancock::Faq.configuration.recreate_contact_message_action, status: 422
        end
      end
      def process_ajax
        true
      end
      def ajax_success
        render partial: success_partial
        # render json: {ok: true}
      end
      def redirect_after_done
        redirect_to action: :sent
      end
      def xhr_checker
        if request.xhr?
          render layout: false
        end
      end
      def after_initialize
      end
      def after_create
        # overrideable hook for updating message
      end
      def form_partial
        "hancock/faq/question/form"
      end
      def success_partial
        "hancock/faq/question/success"
      end
      def question_params
        params[:hancock_faq_question].permit(:question_text, :author_name, :author_email, :captcha, :captcha_key)
      end

      def category_class
        Hancock::Faq::Category
      end
      def question_class
        Hancock::Faq::Question
      end

    end
  end
end
