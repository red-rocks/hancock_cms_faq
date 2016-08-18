module Hancock::Faq
  class CategoriesController < ApplicationController
    include Hancock::Faq::Controllers::Categories

    include Hancock::Faq::Decorators::Categories
  end
end
