module Hancock::Faq
  module Models
    module Mongoid
      module Category
        extend ActiveSupport::Concern

        include Hancock::HtmlField

        included do

          field :name,          type: String, localize: Hancock::Faq.configuration.localize

          acts_as_nested_set
          scope :sorted, -> { order_by([:lft, :asc]) }

          hancock_cms_html_field :excerpt,   type: String, localize: Hancock::Faq.configuration.localize, default: ""
          hancock_cms_html_field :content,   type: String, localize: Hancock::Faq.configuration.localize, default: ""
        end

        def questions
          question_class.in(category_ids: self.id)
        end

        def all_questions
          question_class.any_in(category_ids: self.self_and_descendants.map(&:id))
        end

      end
    end
  end
end
