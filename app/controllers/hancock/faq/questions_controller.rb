module Hancock::Faq
  class QuestionsController < ApplicationController
    include Hancock::Faq::Controllers::Questions

    include Hancock::Faq::Decorators::Questions
  end
end
