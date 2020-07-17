class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string  :name
      t.string  :address
      t.text    :opening_ours
      t.integer :sheets
      t.string  :parking
      t.references :member, foreing_key: true

      t.timestamps
    end
  end
end
