class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname, null: false, limit: 32
      t.integer :uid, null: false
      t.string :provider, null: false, limit: 30
      t.string :gravatar, limit: 32
      t.timestamp :authorized_at

      t.timestamps
    end
    add_index :users, [:provider, :uid]
  end
end
