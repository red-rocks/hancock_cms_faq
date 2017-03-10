module Hancock::Faq
  module Models
    module Mongoid
      module Question
        extend ActiveSupport::Concern

        include Hancock::HtmlField

        included do
          index({main_category_id: 1},            {background: true})
          index({enabled: 1, lft: 1},             {background: true})
          index({category_ids: 1},                {background: true})
          index({answered: 1, answered_time: 1},  {background: true})
          index({created_at: 1},                  {background: true})

          field :question_text
          hancock_cms_html_field :question_text_after_editing, localize: Hancock::Faq.configuration.localize
          field :author_name
          field :author_name_text_after_editing, localize: Hancock::Faq.configuration.localize
          field :author_email

          field :answered, type: Boolean, default: false
          hancock_cms_html_field :answer_text, localize: Hancock::Faq.configuration.localize
          field :answered_time, type: Time
          field :answer_author_name, default: Hancock::Faq.configuration.default_answer_author_name

          has_and_belongs_to_many :categories, class_name: "Hancock::Faq::Category", inverse_of: nil

          acts_as_nested_set
          scope :sorted, -> { order_by([:lft, :asc]) }

          scope :after_now, -> { where(:created_at.lt => Time.now) }
          scope :by_date, -> { desc(:created_at) }
          scope :by_answered_date, -> { desc(:answered_time) }
          scope :answered,      -> { where(answered: true)  }
          scope :not_answered,  -> { where(answered: false) }

          scope :recent, ->(count = 5) { enabled.after_now.by_date.limit(count) }


          def category
            self.categories.enabled.sorted.first
          end

          def question_text_output
            self.question_text_after_editing.blank? ? self.question_text : self.question_text_after_editing
          end

          def author_name_output
            self.author_name_text_after_editing.blank? ? self.author_name : self.author_name_text_after_editing
          end


          if Hancock.rails5?
            if relations.has_key?("updater") and defined?(::Mongoid::History)
              belongs_to :updater, class_name: ::Mongoid::History.modifier_class_name, optional: true, validate: false
              _validators.delete(:updater)
              _validate_callbacks.each do |callback|
                if callback.raw_filter.respond_to?(:attributes) and callback.raw_filter.attributes.include?(:updater)
                  _validate_callbacks.delete(callback)
                end
              end
            end
          end

        end


      end
    end
  end
end
