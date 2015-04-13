json.array!(@orgs) do |org|
  json.extract! org, :id, :name, :permalink, :email, :phone, :owner_id
  json.url org_url(org, format: :json)
end
