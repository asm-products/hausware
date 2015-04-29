json.array!(@ordered_goods) do |ordered_good|
  json.extract! ordered_good, :id, :order_id, :good_id, :name, :quantity, :subtotal_in_cents, :fulfilled_at, :canceled_at
  json.url ordered_good_url(ordered_good, format: :json)
end
