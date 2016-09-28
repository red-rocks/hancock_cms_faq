require 'rails/generators'

module Hancock::Faq
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Hancock::Faq Config generator'
    def config
      template 'hancock_faq.erb', "config/initializers/hancock_faq.rb"
    end

  end
end
