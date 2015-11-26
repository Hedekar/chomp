json.array!(@accounts) do |account|
  json.extract! account, :id, :email, :password_digest
  json.url account_url(account, format: :json)
end
