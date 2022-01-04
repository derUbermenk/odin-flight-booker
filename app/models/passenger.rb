class Passenger < ApplicationRecord
  has_one :booking
  has_one :flight, through: bookings
end
