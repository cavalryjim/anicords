json.array!(@service_providers) do |service_provider|
  json.extract! service_provider, :name, :address1, :address2, :city, :state, :zip, :email, :website, :phone
  json.url service_provider_url(service_provider, format: :json)
end
