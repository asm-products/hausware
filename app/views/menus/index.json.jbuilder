json.array!(@menus) do |menu|
  json.extract! menu, :id, :location_id, :name, :permalink, :position, :sunday_starting, :sunday_ending, :monday_starting, :monday_ending, :tuesday_starting, :tuesday_ending, :wednesday_starting, :wednesday_ending, :thursday_starting, :thursday_ending, :friday_starting, :friday_ending, :saturday_starting, :saturday_ending
  json.url menu_url(menu, format: :json)
end
