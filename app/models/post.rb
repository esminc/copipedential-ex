class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :item, polymorphic: true

  belongs_to :snippet, readonly: true, foreign_key: :item_id, conditions: ['EXISTS(SELECT 1 FROM posts WHERE posts.item_type = ? AND posts.item_id = snippets.id)', 'Snippet']
  belongs_to :picture, readonly: true, foreign_key: :item_id, conditions: ['EXISTS(SELECT 1 FROM posts WHERE posts.item_type = ? AND posts.item_id = pictures.id)', 'Picture']

  validate :user, presence: true
  validate :item, presence: true

  scope :with_items, includes(:snippet, :picture)

  def item
    concreate_item = association(item_type.underscore.to_sym)
    polymorphic_item = association(:item)
    if concreate_item.loaded? && !polymorphic_item.loaded?
      polymorphic_item.target = concreate_item.target
    end
    super
  end
end
