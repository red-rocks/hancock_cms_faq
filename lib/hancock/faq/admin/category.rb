module Hancock::Faq
  module Admin
    module Category
      def self.config(fields = {})
        Proc.new {
          navigation_label "FAQ"

          list do
            scopes [:sorted, :enabled, nil]

            field :enabled, :toggle
            field :name
            # field :image

            field :questions do
              read_only true

              pretty_value do
                bindings[:object].questions.to_a.map { |q|
                  route = bindings[:view] || bindings[:controller]
                  model_name = q.rails_admin_model
                  route.link_to(q.full_name, route.rails_admin.show_path(model_name: model_name, id: q.id), title: q.name)
                }.join("<br>").html_safe
              end
            end
          end

          edit do
            field :enabled, :toggle
            field :name
            # field :sidebar_title, :string

            group :URL, &Hancock::Admin.url_block
            # group :URL do
            #   active false
            #   field :slugs, :hancock_slugs
            #   field :text_slug
            # end
            # field :image, :hancock_image

            # group :content, &Hancock::Admin.content_block
            group :content do
              active false
              field :excerpt, :hancock_html
              field :content, :hancock_html
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


            group :questions do
              active false
              field :questions do
                read_only true
                help 'Список вопросов'

                pretty_value do
                  bindings[:object].questions.to_a.map { |q|
                  route = (bindings[:view] || bindings[:controller])
                  model_name = q.rails_admin_model
                  route.link_to(q.name, route.rails_admin.show_path(model_name: model_name, id: q.id), title: q.full_name)
                  }.join("<br>").html_safe
                end
              end
            end
          end

          show do
            field :name
            # field :sidebar_title
            field :slugs, :hancock_slugs
            field :text_slug
            field :enabled
            # field :image
            field :excerpt
            field :content

            Hancock::RailsAdminGroupPatch::hancock_cms_group(self, fields)

            field :questions do
              read_only true

              pretty_value do
                bindings[:object].questions.to_a.map { |q|
                  route = (bindings[:view] || bindings[:controller])
                  model_name = q.rails_admin_model
                  route.link_to(i.full_name, route.rails_admin.show_path(model_name: model_name, id: q.id), title: q.name)
                }.join("<br>").html_safe
              end
            end
          end

          nested_set({max_depth: 2, scopes: []})

          if block_given?
            yield self
          end

        }
      end
    end
  end
end
