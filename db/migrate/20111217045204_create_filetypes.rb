class CreateFiletypes < ActiveRecord::Migration
  def up
    create_table :filetypes do |t|
      t.string  :name, null: false
      t.boolean :renderable, default: false
    end
    add_column :snippets, :filetype_id, :integer

    Snippet.all.each do |snippet|
      next if (old = snippet.read_attribute(:filetype)).blank?
      ft = Filetype.find_or_create_by_name(old)
      ft.save!
      snippet.update_attribute(:filetype_id, ft.id)
    end

    remove_column :snippets, :filetype
  end

  def down
    remove_column :snippets, :filetype_id
    add_column :snippets, :filetype, :string
    drop_table :filetypes
  end
end
