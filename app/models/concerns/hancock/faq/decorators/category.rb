module Hancock::Faq::Decorators
  module Category
    extend ActiveSupport::Concern

    included do
      # def self.default_cache_keys
      #   []
      # end
      #
      # #############   rails_admin ##############
      # def self.rails_admin_add_fields
      #   {}
      # end
      #
      # def self.rails_admin_add_config(config)
      # end
      #
      # def self.admin_can_user_defined_actions
      #   [].freeze
      # end
      # def self.admin_cannot_user_defined_actions
      #   [].freeze
      # end
      # def self.manager_can_user_defined_actions
      #   [].freeze
      # end
      # def self.manager_cannot_user_defined_actions
      #   [].freeze
      # end
      # def self.rails_admin_user_defined_visible_actions
      #   [].freeze
      # end
    end

  end
end
