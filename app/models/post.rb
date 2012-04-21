class Post < ActiveRecord::Base
  extend EagerLoadablePolymorph
  belongs_to :user
  belongs_to :item, polymorphic: true

  eager_loadable_polymorphic_association :item, [:snippet, :picture]
  # XXX refactor
  scope :recent, ->(limit = nil) do
    o = order("#{quoted_table_name}.updated_at DESC")
    limit ? o.limit(limit.to_i) : o
  end

  validate :user, presence: true
  validate :item, presence: true

end
