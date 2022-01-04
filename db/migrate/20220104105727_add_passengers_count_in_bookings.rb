class AddPassengersCountInBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :passengers_count, :integer
  end
end
