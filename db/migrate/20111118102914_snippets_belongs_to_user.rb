class SnippetsBelongsToUser < ActiveRecord::Migration
  def change
    raise 'oh, no user' if Snippet.count > 1 && User.count.zero?
    add_column :snippets, :author_id, :integer
    Snippet.update_all(author_id: User.first.id)
    change_column :snippets, :author_id, :integer, null: false
    remove_column :snippets, :author
  end
end
