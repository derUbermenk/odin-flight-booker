class Booking < ApplicationRecord
  belongs_to :passenger
  belongs_to :flight, counter_cache: :passenger_count
end
