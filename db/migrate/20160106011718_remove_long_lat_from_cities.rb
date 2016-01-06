class RemoveLongLatFromCities < ActiveRecord::Migration
  def change
    remove_column :cities, :long, :decimal
    remove_column :cities, :lat, :decimal
  end
end
