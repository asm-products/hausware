json.array!(@locations) do |location|
  json.extract! location, :id, :name, :permalink, :phone, :email, :latitude, :longitude, :street_address1, :street_address2, :city, :state_province_region, :zip_postal_code, :country_code, :sunday_opening, :sunday_closing, :monday_opening, :monday_closing, :tuesday_opening, :tuesday_closing, :wednesday_opening, :wednesday_closing, :thursday_opening, :thursday_closing, :friday_opening, :friday_closing, :saturday_opening, :saturday_closing
  json.url location_url(location, format: :json)
end
