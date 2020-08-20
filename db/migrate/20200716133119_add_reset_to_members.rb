class AddResetToMembers < ActiveRecord::Migration[6.0]
  def change
    change_table :members, bulk: true do |t|
      t.column :reset_digest, :string
      t.column :reset_sent_at, :datetime
    end
  end
end
