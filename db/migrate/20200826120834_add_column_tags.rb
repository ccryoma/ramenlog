class AddColumnTags < ActiveRecord::Migration[6.0]
  def change
    change_table :tags, bulk: true do |t|
      t.column :type, :integer
    end
  end
end
