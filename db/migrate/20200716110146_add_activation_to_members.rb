class AddActivationToMembers < ActiveRecord::Migration[6.0]
  def change
    change_table :members, bulk: true do |t|
      t.column :activation_digest, :string
      t.column :activated, :boolean, default: false
      t.column :activated_at, :datetime
    end
  end
end
