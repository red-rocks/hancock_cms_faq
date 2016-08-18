require "hancock/faq/version"

require 'hancock/faq/routes'

require 'hancock/faq/configuration'
require 'hancock/faq/engine'

module Hancock::Faq
  # Hancock::register_plugin(self)

  class << self
    def orm
      :mongoid
    end
    def mongoid?
      Hancock::Faq.orm == :mongoid
    end
    def active_record?
      Hancock::Faq.orm == :active_record
    end
    def model_namespace
      "Hancock::Faq::Models::#{Hancock::Faq.orm.to_s.camelize}"
    end
    def orm_specific(name)
      "#{model_namespace}::#{name}".constantize
    end
  end

  autoload :Admin,  'hancock/faq/admin'
  module Admin
    autoload :Question,               'hancock/faq/admin/question'
    autoload :Category,               'hancock/faq/admin/category'
  end

  module Models
    autoload :Question,               'hancock/faq/models/question'
    autoload :Category,               'hancock/faq/models/category'

    module Mongoid
      autoload :Question,               'hancock/faq/models/mongoid/question'
      autoload :Category,               'hancock/faq/models/mongoid/category'
    end
  end

  module Controllers
    autoload :Questions,                'hancock/faq/controllers/questions'
    autoload :Categories,               'hancock/faq/controllers/categories'
  end
end
