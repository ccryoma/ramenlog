class ChangeDataLatlngToShops < ActiveRecord::Migration[6.0]
  def change
    change_table :shops, bulk: true do |t|
      t.column :latitude, :double, precision: 9, scale: 6
      t.column :longitude, :double, precision: 9, scale: 6
    end
  end
end
