json.array!(@users) do |user|
  json.extract! user, :id, :name, :sex, :department, :telephone, :email
  json.url user_url(user, format: :json)
end
