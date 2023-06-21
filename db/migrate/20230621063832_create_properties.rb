class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string :property
      t.integer :rent
      t.string :address
      t.integer :building_age
      t.text :remarks

      t.timestamps
    end
  end
end
