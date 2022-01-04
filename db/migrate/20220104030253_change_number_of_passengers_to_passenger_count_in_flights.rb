class ChangeNumberOfPassengersToPassengerCountInFlights < ActiveRecord::Migration[6.1]
  def change
    rename_column :flights, :number_of_passengers, :passenger_count
  end
end
