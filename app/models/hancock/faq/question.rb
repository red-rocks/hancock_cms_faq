module Hancock::Faq
  class Question
    include Hancock::Faq::Models::Question

    include Hancock::Faq::Decorators::Question

    rails_admin(&Hancock::Faq::Admin::Question.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
