class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname, null: false
      t.string :uid, null: false
      t.string :provider, null: false
      t.string :gravatar
      t.timestamp :authorized_at

      t.timestamps
    end
    add_index :users, [:provider, :uid]
  end
end
