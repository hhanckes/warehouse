# encoding: UTF-8
class MainController < ApplicationController
  def home
  end
  
  def admin
  end
  
  def faqs
    @faq_sections = FaqSection.all
  end
end
