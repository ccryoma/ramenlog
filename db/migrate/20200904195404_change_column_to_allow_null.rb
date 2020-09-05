class ChangeColumnToAllowNull < ActiveRecord::Migration[6.0]
  def change
    change_table :shopstotals, bulk: true do |t|
      t.column :latest_post_id, :bigint, foreign_key: { to_table: :posts }, null: true
      t.column :latest_img_id, :bigint, foreign_key: { to_table: :posts }, null: true
    end
  end
end
