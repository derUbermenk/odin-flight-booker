class Flight < ApplicationRecord
  has_many :bookings, dependent: :delete_all
  has_many :passengers, through: :bookings

  belongs_to :arrival_airport, class_name: 'Airport'
  belongs_to :departure_airport, class_name: 'Airport'

  def route
    { arrival: self.arrival_airport, departure: self.departure_airport }
  end
end
