class CreatePost < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.belongs_to :user
      t.belongs_to :item, polymorphic: true, null: false
      t.timestamps
    end

    add_index :posts, [:item_type, :item_id]
  end

  def down
    remove_index :posts, [:item_type, :item_id]
    drop_table :pots
  end
end
