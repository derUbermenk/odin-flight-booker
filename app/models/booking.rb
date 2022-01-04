class Booking < ApplicationRecord
  has_many :passengers, dependent: :delete_all

  belongs_to :flight
end
