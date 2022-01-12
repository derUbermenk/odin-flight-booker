class Passenger < ApplicationRecord
  belongs_to :booking, counter_cache: true

  validates :name, :email, presence: true
end
