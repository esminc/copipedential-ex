class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :author
      t.string :title
      t.text :body
      t.string :filetype

      t.timestamps
    end
  end
end
