class ReCreateShopstotal < ActiveRecord::Migration[6.0]
  def change
    create_table :shopstotals do |t|
      t.references :shop, null: false, foreign_key: true
      t.decimal :point_avg, precision: 2, scale: 1
      t.references :latest_post, foreign_key: { to_table: :posts }, null: true
      t.references :latest_img, foreign_key: { to_table: :posts }, null: true

      t.timestamps
    end
  end
end
