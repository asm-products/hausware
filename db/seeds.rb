# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


hana_org = Org.find_by_permalink('hana')
if hana_org.blank?
  hana_org = Org.create!(
    {
      name: 'HanaHaus',
      permalink: 'hana',
      url: 'http://hanahaus.com',
      phone: '(650) 326-1263',
      email: 'info@hanahaus.com'
    }
  )
  puts "Creating org: #{hana_org.permalink}: #{hana_org.id.to_s}"
end

palo_alto_location = Location.find_by_permalink('palo-alto')
if palo_alto_location.blank?
  palo_alto_location = Location.create!(
    {
      name: 'Palo Alto',
      permalink: 'palo-alto',
      org: hana_org,
      phone: '(650) 326-1263',
      email: 'info@hanahaus.com',
      timezone: 'Pacific Time (US & Canada)',
      street_address1: 'New Varsity Theatre',
      street_address2: '456 University Ave.',
      city: 'Palo Alto',
      state_province_region: 'CA',
      zip_postal_code: '94301',
      country_code: 'US',
      latitude: 37.4475590,
      longitude: -122.1595500,
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
  puts "Creating location: #{palo_alto_location.permalink}: #{palo_alto_location.id.to_s}"
end

PALO_ALTO_SPACES = [
  {
    location:                        palo_alto_location,
    name:                            'Open Seating',
    permalink:                       'open-seating',
    standard_hourly_price_in_cents:  300,
    picurl:                          nil,
    reservable_quantity:             65,
    max_days_in_advance_reservable:  2,
    description:                     'Single seats available either on tables or lounge-style furniture in a variety of configurations. Ample power outlets, whiteboards, wifi, and a printer. Sit anywhere and move around as you please to collaborate, work, and to learn. Since there is limited Open seating, please be considerate and book no more than a couple of hours at a time.'
  },
  {
    location:                        palo_alto_location,
    name:                            '2-Seat Quiet Room – Right',
    permalink:                       'quiet-room-right',
    standard_hourly_price_in_cents:  1500,
    picurl:                          nil,
    reservable_quantity:             1,
    max_days_in_advance_reservable:  2,
    description:                     'A small, private meeting room perfect for a one-on-one meeting or phone call.'
  },
  {
    location:                        palo_alto_location,
    name:                            '2-Seat Quiet Room – Left',
    permalink:                       'quiet-room-left',
    standard_hourly_price_in_cents:  1500,
    picurl:                          nil,
    reservable_quantity:             1,
    max_days_in_advance_reservable:  2,
    description:                     'A small, private meeting room perfect for a one-on-one meeting or phone call.'
  },
  {
    location:                        palo_alto_location,
    name:                            'Conference – West',
    permalink:                       'conference-room-west',
    standard_hourly_price_in_cents:  7500,
    picurl:                          nil,
    reservable_quantity:             1,
    max_days_in_advance_reservable:  2,
    description:                     'An 8-person private meeting room with 65" LED Screen and A/V hook-ups. Seats up to 10 very snuggly.'
  },
  {
    location:                        palo_alto_location,
    name:                            'Conference – East',
    permalink:                       'conference-room-east',
    standard_hourly_price_in_cents:  7500,
    picurl:                          nil,
    reservable_quantity:             1,
    max_days_in_advance_reservable:  2,
    description:                     'An 8-person private meeting room with 65" LED Screen and A/V hook-ups. Seats up to 10 very snuggly.'
  },
  {
    location:                        palo_alto_location,
    name:                            '8-Person Group Table',
    permalink:                       'group-tabletop',
    standard_hourly_price_in_cents:  2000,
    picurl:                          nil,
    reservable_quantity:             2,
    max_days_in_advance_reservable:  2,
    description:                     'Large communal table for group work and collaboration in an open workspace.'
  },
  {
    location:                        palo_alto_location,
    name:                            '4-Person Lounge with TV',
    permalink:                       'lounge-seating',
    standard_hourly_price_in_cents:  3500,
    picurl:                          nil,
    reservable_quantity:             2,
    max_days_in_advance_reservable:  2,
    description:                     'Comfortable work enabled lounge furniture arranged around a coffee table in the open workspace with one 65" screen and A/V hookups for presentations.'
  },
]

PALO_ALTO_SPACES.each do |space_attributes|
  result = Space.create(space_attributes)
  puts "Creating space: #{result.permalink}: #{result.id.to_s}"
end
