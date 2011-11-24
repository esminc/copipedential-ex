class CreateMention < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.integer :snippet_id, null: false
      t.integer :mentioned_id, null: false

      t.timestamp
    end
    add_index :mentions, [:snippet_id, :mentioned_id]
  end
end
