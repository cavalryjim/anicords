json.array!(@animals) do |animal|
  json.extract! animal, :name, :type, :breed, :weight, :description
  json.url animal_url(animal, format: :json)
end
