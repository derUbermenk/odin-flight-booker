class Flight < ApplicationRecord
  has_many :bookings, dependent: :delete_all

  belongs_to :arrival_airport, class_name: 'Airport'
  belongs_to :departure_airport, class_name: 'Airport'

  scope :passenger_count, -> { bookings.map(&:passengers_count).sum }

  def route
    { arrival: self.arrival_airport, departure: self.departure_airport }
  end
end
