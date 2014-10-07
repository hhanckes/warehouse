json.array!(@faq_sections) do |faq_section|
  json.extract! faq_section, :id, :name, :description
  json.url faq_section_url(faq_section, format: :json)
end
