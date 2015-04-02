json.array!(@spaces) do |space|
  json.extract! space, :id, :location_id, :name, :permalink, :standard_hourly_price_in_cents, :picurl, :reservable_quantity, :description
  json.url space_url(space, format: :json)
end
