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

      include Hancock::Faq.orm_specific('Category')

      included do
        manual_slug :name

        def self.manager_can_add_actions
          [:nested_set]
        end
        def self.rails_admin_add_visible_actions
          [:nested_set]
        end
      end

      def question_class
        Hancock::Faq::Question
      end
    end
  end
end
