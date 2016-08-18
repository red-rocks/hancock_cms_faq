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
      end

      def clean_excerpt
        self.excerpt ||= ""
        Rails::Html::FullSanitizer.new.sanitize(self.excerpt.strip)
      end

      def clean_content
        self.content ||= ""
        Rails::Html::FullSanitizer.new.sanitize(self.content.strip)
      end

      def question_class
        Hancock::Faq::Question
      end
    end
  end
end
