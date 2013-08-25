json.array!(@users) do |user|
  json.extract! user, :first_name, :middle_name, :last_name, :email, :address1, :address2, :city, :state, :zip, :phone
  json.url user_url(user, format: :json)
end
