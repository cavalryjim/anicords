json.array!(@breeders) do |breeder|
  json.extract! breeder, :name, :address1, :address2, :city, :state, :zip, :phone, :website, :email
  json.url breeder_url(breeder, format: :json)
end
