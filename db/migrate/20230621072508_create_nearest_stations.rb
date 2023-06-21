class CreateNearestStations < ActiveRecord::Migration[6.0]
  def change
    create_table :nearest_stations do |t|
      t.string :name_of_railway
      t.string :station_name
      t.string :how_many_minuites_walk
      t.timestamps
    end
  end
end
