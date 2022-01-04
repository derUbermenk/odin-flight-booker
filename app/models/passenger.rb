class Passenger < ApplicationRecord
  has_many :bookings, dependent: :delete_all
  has_many :flights, through: :bookings
end
