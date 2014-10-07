json.array!(@storage_items) do |storage_item|
  json.extract! storage_item, :id, :name, :description, :price, :width, :height, :depth, :dimensions_measure, :capacity, :capacity_measure
  json.url storage_item_url(storage_item, format: :json)
end
