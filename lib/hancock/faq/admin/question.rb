module Hancock::Faq
  module Admin
    module Question
      def self.config(fields = {})
        Proc.new {
          navigation_label "FAQ"

          list do
            scopes [:by_date, :by_answered_date, :answered, :not_answered, :enabled, nil]

            field :enabled, :toggle
            field :main_category
            field :categories
            field :full_name
          end

          edit do
            group :categories do
              active false
              field :main_category
              field :categories
            end
            field :enabled, :toggle

            group :URL, &Hancock::Admin.url_block
            # group :URL do
            #   active false
            #   field :slugs, :hancock_slugs
            #   field :text_slug
            # end

            group 'Данные вопроса' do
              active false
              field :question_text, :text
              field :question_text_after_editing, :hancock_html
              field :author_name, :string
              field :author_name_text_after_editing, :string
              field :author_email, :string
            end

            group 'Данные ответа' do
              active false
              field :answered, :toggle
              field :answer_text, :hancock_html
              field :answered_time
              field :answer_author_name, :string
            end

            if Hancock::Faq.config.seo_support
              group :seo_n_sitemap, &Hancock::Seo::Admin.seo_n_sitemap_block
              # group :seo do
              #   active false
              #   field :seo
              # end
              # group :sitemap_data do
              #   active false
              #   field :sitemap_data
              # end
            end

            Hancock::RailsAdminGroupPatch::hancock_cms_group(self, fields)

          end

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
