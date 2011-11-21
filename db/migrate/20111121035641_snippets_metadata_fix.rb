class SnippetsMetadataFix < ActiveRecord::Migration
  def change
    rename_column :snippets, :title, :name
    add_column :snippets, :description, :string, limit: 200
  end
end
