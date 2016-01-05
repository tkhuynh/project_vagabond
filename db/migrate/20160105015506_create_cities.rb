class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.decimal :long
      t.decimal :lat

      t.timestamps null: false
    end
  end
end
