json.array!(@reservations) do |reservation|
  json.extract! reservation, :id, :space_id, :user_id, :name, :email, :phone, :zipcode, :starts_at, :ends_at, :chargeid
  json.url reservation_url(reservation, format: :json)
end
