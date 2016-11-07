require 'rails/generators'

module Hancock::Faq::Models
  class QuestionGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :class_name, type: :string

    desc 'Hancock::Faq Question Model generator'
    def question
      template 'question.erb', "app/models/#{file_name}.rb"
    end

    private
    def capitalized_class_name
      class_name.capitalize
    end

    def camelcased_class_name
      class_name.camelcase
    end

    def file_name
      underscored_class_name
    end

    def underscored_class_name
      camelcased_class_name.underscore
    end

    def underscored_pluralized_class_name
      underscored_class_name.pluralize
    end
  end
end
