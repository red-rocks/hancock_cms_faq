module Hancock::Faq
  module Models
    module Category
      extend ActiveSupport::Concern
      include Hancock::Model
      include Hancock::Enableable

      if Hancock::Faq.config.seo_support
        include Hancock::Seo::Seoable
        include Hancock::Seo::SitemapDataField
      end
      include ManualSlug

      if Hancock::Pages.config.cache_support
        include Hancock::Cache::Cacheable
      end

      include Hancock::Faq.orm_specific('Category')

      included do
        if Hancock::Feedback.config.model_settings_support
          include RailsAdminModelSettings::ModelSettingable
        end

        manual_slug :name

        def self.manager_can_add_actions
          ret = [:nested_set]
          ret << :model_settings if Hancock::Faq.config.model_settings_support
          # ret << :model_accesses if Hancock::Faq.config.user_abilities_support
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

      def question_class
        Hancock::Faq::Question
      end
    end
  end
end
