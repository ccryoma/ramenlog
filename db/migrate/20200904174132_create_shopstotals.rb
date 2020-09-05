class CreateShopstotals < ActiveRecord::Migration[6.0]
  def change
    create_table :shopstotals do |t|
      t.references :shop, null: false, foreign_key: true
      t.decimal :point_avg, precision: 2, scale: 1
      t.references :latest_post_id, foreign_key: { to_table: :posts }
      t.references :latest_img_id, foreign_key: { to_table: :posts }

      t.timestamps
    end
  end
end
