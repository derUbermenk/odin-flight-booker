class CreateFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :flights do |t|
      t.datetime :start
      t.integer :duration_m
      t.references :arrival_airport, index: true, foreign_key: { to_table: :airports }
      t.references :departure_airport, index: true, foreign_key: { to_table: :airports }

      t.timestamps
    end
  end
end
