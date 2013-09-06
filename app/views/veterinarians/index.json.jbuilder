json.array!(@veterinarians) do |veterinarian|
  json.extract! veterinarian, :clinic_name, :address1, :address2, :city, :state, :zip, :phone, :email
  json.url veterinarian_url(veterinarian, format: :json)
end
