json.array!(@goods) do |good|
  json.extract! good, :id, :menu_id, :name, :permalink, :price_in_cents, :picurl, :description
  json.url good_url(good, format: :json)
end
