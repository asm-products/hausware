json.array!(@memberships) do |membership|
  json.extract! membership, :id, :org_id, :location_id, :user_id, :privileges
  json.url membership_url(membership, format: :json)
end
