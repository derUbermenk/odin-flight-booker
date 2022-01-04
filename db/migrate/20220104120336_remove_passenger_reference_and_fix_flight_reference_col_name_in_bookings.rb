class RemovePassengerReferenceAndFixFlightReferenceColNameInBookings < ActiveRecord::Migration[6.1]
  def change
    change_table :bookings do |t|
      t.remove :passenger_id_id
      t.rename :flight_id_id, :flight_id
    end
  end
end
