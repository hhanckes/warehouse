json.array!(@stored_items) do |stored_item|
  json.extract! stored_item, :id, :order_storage_item_id, :name, :description, :assigned_value
  json.url stored_item_url(stored_item, format: :json)
end
