class Passenger < ApplicationRecord
  belongs_to :booking, counter_cache: true
end
