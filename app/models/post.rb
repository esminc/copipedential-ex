class Post < ActiveRecord::Base
  extend EagerLoadablePolymorph
  belongs_to :user
  belongs_to :item, polymorphic: true

  eager_loadable_polymorphic_association :item, [:snippet, :picture]

  validate :user, presence: true
  validate :item, presence: true

  scope :with_items, includes(:snippet, :picture)

end
