# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

airport_codes = %w[VRC MNL NYC LEG NGA BSC CDO DVO GOA]

def create_flight
  start = DateTime.new(2022, [*1..12].sample, [*1..31].sample, [*8..17].sample, [0, 30, 45].sample)
  duration = [60, 30, 45].sample

  arrival_airport = Airport.all.sample
  departure_airport = Airport.all.excluding(arrival_airport).sample

  Flight.create(
    start: start, duration_m: duration,
    arrival_airport: arrival_airport,
    departure_airport: departure_airport
  )
end

8.times do |i|
  Airport.create(code: airport_codes[i])
end


20.times do 
  create_flight
end