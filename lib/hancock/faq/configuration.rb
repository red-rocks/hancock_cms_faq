module Hancock::Faq
  include Hancock::PluginConfiguration

  def self.config_class
    Configuration
  end

  class Configuration
    attr_accessor :author_name_required

    attr_accessor :default_answer_author_name

    attr_accessor :save_with_captcha
    attr_accessor :captcha_error_message

    attr_accessor :recaptcha_support
    attr_accessor :simple_captcha_support

    attr_accessor :seo_support

    attr_accessor :localize

    def initialize
      @author_name_required = true

      @default_answer_author_name  = "Администрация сайта"

      @captcha_error_message = "Код с картинки введен неверно"

      @recaptcha_support = defined?(Recaptcha)
      @simple_captcha_support = defined?(SimpleCaptcha)
      @save_with_captcha = @recaptcha_support || @simple_captcha_support

      @seo_support = defined?(Hancock::Seo)

      @breadcrumbs_on_rails_support = defined?(BreadcrumbsOnRails)

      @localize = Hancock.config.localize
    end
  end
end
