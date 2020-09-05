class AddShopToTotalsId < ActiveRecord::Migration[6.0]
  def change
    add_reference :shops, :latest_post, foreign_key: { to_table: :posts }, null: true
    add_reference :shops, :latest_img, foreign_key: { to_table: :posts }, null: true
  end
end
