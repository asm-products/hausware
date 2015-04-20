json.array!(@settings) do |setting|
  json.extract! setting, :id, :org_id, :default_location_spaces, :stripe_publishable_key, :stripe_secret_key_encrypted, :salt
  json.url setting_url(setting, format: :json)
end
