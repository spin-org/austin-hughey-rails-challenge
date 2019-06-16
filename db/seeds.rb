# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#
# POINT(lon, lat)
# ...is how we're setting locations.
#

@scooter = Scooter.create(
  active: true
)

location_pairs = [
  #
  # Frost Bank ATM in Austin
  # East side of the street, Brazos & 7th
  #
  [-97.7411765,30.2687328],

  #
  # Point just north of that
  #
  [-97.7410692,30.268873],

  #
  # Brazos and 8th
  #
  [-97.7408848,30.269362],

  #
  # Across the street
  #
  [-97.7408848,30.269362],

  #
  # Down to CU29 Bar
  #
  [-97.7411611,30.2692039],

  #
  # Back down to Brazos and 7th
  # Other side of the street
  #
  [-97.7412248,30.2688096]
]

#
# Create reports showing a basic trip around the street from the Omni at
# Downtown Austin on Brazos and 7th, up the street to 8th, across the street,
# back down to CU29 bar (right across the street from the Omni), then back
# down to 7th and Brazos on the west side of Brazos this time.
# To visualize this, check out this google maps url:
#   https://www.google.com/maps/@30.2690879,-97.7408949,20z

location_pairs.each_with_index do |loc, i|
  Report.create(
    scooter: @scooter,
    battery_level: 88.7 - (i / 88.7),
    location: "POINT(#{loc[0]} #{loc[1]})")
end

@ticket = Ticket.create(
  scooter: @scooter,
  opened_by: 'jah@jah.io',
  deactivate_scooter: false,
  notes: "Hello from the initial database seed! This is only a test note."
)