module Hancock::Faq
  class Category
    include Hancock::Faq::Models::Category

    include Hancock::Faq::Decorators::Category

    rails_admin(&Hancock::Faq::Admin::Category.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
