json.array!(@orders) do |order|
  json.extract! order, :id, :user_id, :location_id, :fulfilled_at, :delivered_at, :name, :email, :phone, :zipcode, :confirmation, :subtotal_in_cents, :tax_in_cents, :total_in_cents, :chargeid, :canceled_at
  json.url order_url(order, format: :json)
end
