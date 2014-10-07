json.array!(@testimonies) do |testimony|
  json.extract! testimony, :id, :name, :title, :content
  json.url testimony_url(testimony, format: :json)
end
