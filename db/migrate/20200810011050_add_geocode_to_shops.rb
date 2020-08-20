class AddGeocodeToShops < ActiveRecord::Migration[6.0]
  def change
    change_table :shops, bulk: true do |t|
      t.column :latitude, :float
      t.column :longitude, :float
    end
  end
end
