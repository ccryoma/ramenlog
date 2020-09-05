class AddShopToTotals < ActiveRecord::Migration[6.0]
  def change
    change_table :shops, bulk: true do |t|
      t.column :point_avg, :decimal, precision: 2, scale: 1
    end
  end
end
