module Hancock::Faq
  module Models
    module Question
      extend ActiveSupport::Concern
      include Hancock::Model
      include Hancock::Enableable

      if Hancock::Faq.config.seo_support
        include Hancock::Seo::Seoable
        include Hancock::Seo::SitemapDataField
      end
      include ManualSlug

      include Hancock::Faq.orm_specific('Question')

      included do
        manual_slug :full_name

        if Hancock::Faq.config.simple_captcha_support
          include SimpleCaptcha::ModelHelpers
          apply_simple_captcha message: Hancock::Faq.configuration.captcha_error_message
        end

        validates_email_format_of :author_email
        if Hancock::Faq.config.author_name_required
          validates_presence_of :author_name
        end
        validates_presence_of :question_text, :author_email
      end

      def name
        "#{self.question_text_output} (#{self.author_name_output})"
      end

      def full_name
        "#{self.author_name_output}: \"#{self.question_text_output}\""
      end

      def category_class
        Hancock::Faq::Category
      end

    end
  end
end
