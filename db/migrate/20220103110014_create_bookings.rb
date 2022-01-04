class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :passenger_id, index: true
      t.references :flight_id, index: true

      t.timestamps
    end
  end
end
