json.array!(@reservations) do |reservation|
  json.extract! reservation, :id, :space_id, :user_id, :confirmation, :name, :email, :phone, :zipcode, :starts_at, :ends_at, :price_in_cents, :chargeid, :checked_in_at, :canceled_at
  json.url reservation_url(reservation, format: :json)
end
