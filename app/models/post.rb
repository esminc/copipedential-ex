class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :item, polymorphic: true

  validate :user, presence: true
  validate :item, presence: true

  scope :with_items, {}
end
