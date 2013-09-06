json.array!(@households) do |household|
  json.extract! household, :name, :address1, :address2, :phone
  json.url household_url(household, format: :json)
end
