# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

palo_alto_location = Location.find_by_permalink('palo-alto')
if palo_alto_location.blank?
  palo_alto_location = Location.create!(
    {
      name: 'Palo Alto',
      permalink: 'palo-alto',
      phone: '650.326.1263',
      email: 'info@hanahaus.com',
      street_address1: 'New Varsity Theatre',
      street_address2: '456 University Ave.',
      city: 'Palo Alto',
      state_province_region: 'CA',
      zip_postal_code: '94301',
      country_code: 'US',
      sunday_opening: 700, 
      sunday_closing: 2100,
      monday_opening: 700,  
      monday_closing: 2100,
      tuesday_opening: 700, 
      tuesday_closing: 2100,
      wednesday_opening: 700, 
      wednesday_closing: 2100,
      thursday_opening: 700, 
      thursday_closing: 2100,
      friday_opening: 700, 
      friday_closing: 2200,
      saturday_opening: 700, 
      saturday_closing: 2200
    }
  )
end