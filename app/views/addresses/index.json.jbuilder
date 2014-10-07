json.array!(@addresses) do |address|
  json.extract! address, :id, :receiver, :name, :post_code, :area_id, :user_id
  json.url address_url(address, format: :json)
end
