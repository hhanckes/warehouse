json.array!(@faqs) do |faq|
  json.extract! faq, :id, :faq_section_id, :question, :answer
  json.url faq_url(faq, format: :json)
end
