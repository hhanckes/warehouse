json.array!(@storage_item_return_proofs) do |storage_item_return_proof|
  json.extract! storage_item_return_proof, :id, :comments
  json.url storage_item_return_proof_url(storage_item_return_proof, format: :json)
end
