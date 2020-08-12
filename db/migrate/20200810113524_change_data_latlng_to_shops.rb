class ChangeDataLatlngToShops < ActiveRecord::Migration[6.0]
  def change
    change_column :shops, :latitude, :double, precision: 9, scale: 6
    change_column :shops, :longitude, :double, precision: 9, scale: 6
  end
end
