class ReDropShopstotals < ActiveRecord::Migration[6.0]
  def change
    drop_table :shopstotals
  end
end
