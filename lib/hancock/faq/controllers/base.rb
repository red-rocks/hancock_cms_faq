module Hancock::Faq
  module Controllers
    module Base
      extend ActiveSupport::Concern

      included do

        private
        def category_class
          Hancock::Faq::Category
        end
        def category_scope
          category_class.enabled
        end
        def category_index_scope
          category_scope.sorted
        end
        def category_show_scope
          category_scope
        end

        def question_class(category = nil)
          category ? category.question_class : Hancock::Faq::Question
        end
        def question_scope(category = nil)
          category ? category.questions.enabled : question_class.enabled
        end
        def questions_index_scope(category = nil)
          questions_scope(category).order(question_class.sorting_order)
        end
        def question_show_scope(category = nil)
          question_scope(category)
        end

        def after_initialize
        end

        def insert_breadcrumbs
          true
        end
        def insert_categories_index_breadcrumbs
          hancock_faq_categories_path if insert_breadcrumbs
        end
        def insert_category_show_breadcrumbs
          hancock_faq_category_path(@category) if @category if insert_breadcrumbs
        end
        def insert_question_index_breadcrumbs
          hancock_faq_questions_index_path if insert_breadcrumbs
        end
        def insert_question_show_breadcrumbs
          hancock_faq_question_path(@question) if @question if insert_breadcrumbs
        end

        def breadcrumbs_categories_title
          I18n.t('hancock.breadcrumbs.faq.categories')
        end
        def breadcrumbs_question_title
          I18n.t('hancock.breadcrumbs.faq.questions')
        end
      end

    end
  end
end
