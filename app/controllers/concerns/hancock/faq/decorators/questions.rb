module Hancock::Faq::Decorators
  module Questions
    extend ActiveSupport::Concern

    # included do
    #
    #   def hancock_faq_update_captcha_path
    #     url_for(action: :update_captcha, time: Time.new.to_i, only_path: true)
    #   end
    #   def cache_fields?
    #     ['new', 'index'].include? action_name
    #   end
    #   def cache_key
    #     'hancock_faq_question_fields'.freeze
    #   end
    #   def fields_partial
    #     "hancock/faq/questions/#{(Hancock::Faq.config.model_settings_support ? 'fields' : 'fields_with_settings')}".freeze
    #   end
    #   def settings_scope
    #     if Hancock::Faq.config.model_settings_support
    #       question_class.settings
    #     elsif defined?(Settings)
    #       Settings.ns('FAQ')
    #     else
    #       nil
    #     end
    #   end
    #
    #   def render_faq_error
    #     if request.xhr? && process_ajax
    #       render partial: form_partial, status: 422
    #       # render json: {errors: @contact_message.errors}, status: 422
    #     else
    #       flash.now[:alert] = @question.errors.full_messages.join("\n")
    #       render action: Hancock::Faq.configuration.recreate_contact_message_action, status: 422
    #     end
    #   end
    #   def process_ajax
    #     true
    #   end
    #   def ajax_success
    #     render partial: success_partial
    #     # render json: {ok: true}
    #   end
    #   def redirect_after_done
    #     redirect_to action: :sent
    #   end
    #   def xhr_checker
    #     if request.xhr?
    #       render layout: false
    #     end
    #   end
    #   def after_initialize
    #   end
    #   def after_create
    #     # overrideable hook for updating message
    #   end
    #   def form_partial
    #     "hancock/faq/questions/form"
    #   end
    #   def success_partial
    #     "hancock/faq/questions/success"
    #   end
    #   def question_params
    #     params[:hancock_faq_question].permit(:question_text, :author_name, :author_email, :captcha, :captcha_key)
    #   end
    #
    # end

  end
end
