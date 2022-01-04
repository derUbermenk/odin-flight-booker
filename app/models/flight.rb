class Flight < ApplicationRecord
  has_many :bookings, dependent: :delete_all

  belongs_to :arrival_airport, class_name: 'Airport'
  belongs_to :departure_airport, class_name: 'Airport'

  

  def route
    { arrival: arrival_airport, departure: departure_airport }
  end

  def passenger_count
    bookings.map(&:passengers_count).sum
  end
end
