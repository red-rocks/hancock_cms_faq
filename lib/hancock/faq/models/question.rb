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

      if Hancock::Pages.config.cache_support
        include Hancock::Cache::Cacheable
      end
      
      include ManualSlug

      include Hancock::Faq.orm_specific('Question')

      included do
        if Hancock.rails4?
          belongs_to :main_category, class_name: "Hancock::Faq::Category", inverse_of: nil
        else
          belongs_to :main_category, class_name: "Hancock::Faq::Category", inverse_of: nil, optional: true
        end
        before_validation :set_default_main_category
        def set_default_main_category(force = false)
          if force or main_category.blank? or !main_category.enabled and self.respond_to?(:categories)
            self.main_category = self.categories.enabled.sorted.first
          end
        end

        if Hancock::Feedback.config.model_settings_support
          include RailsAdminModelSettings::ModelSettingable
        end

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

        def self.manager_can_add_actions
          ret = [:nested_set]
          ret << :model_settings if Hancock::Faq.config.model_settings_support
          ret << :model_accesses if Hancock::Faq.config.user_abilities_support
          ret << :hancock_touch if Hancock::Faq.config.cache_support
          ret += [:comments, :model_comments] if Hancock::Faq.config.ra_comments_support
          ret.freeze
        end
        def self.rails_admin_add_visible_actions
          ret = [:nested_set]
          ret << :model_settings if Hancock::Faq.config.model_settings_support
          ret << :model_accesses if Hancock::Faq.config.user_abilities_support
          ret << :hancock_touch if Hancock::Faq.config.cache_support
          ret += [:comments, :model_comments] if Hancock::Faq.config.ra_comments_support
          ret.freeze
        end
      end

      def name
        "#{self.question_text_output} (#{self.author_name_output})".freeze
      end

      def full_name
        "#{self.author_name_output}: \"#{self.question_text_output}\"".freeze
      end

      def category_class
        Hancock::Faq::Category
      end

    end
  end
end
