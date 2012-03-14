class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string  :name, limit: 50
      t.string  :description
      t.string  :key, null: false
      t.integer :author_id, null: false

      t.timestamps null: false
    end
    add_index :pictures, :author_id
  end
end
