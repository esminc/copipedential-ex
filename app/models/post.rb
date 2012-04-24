class Post < ActiveRecord::Base
  module CallbackMixin
    extend ActiveSupport::Concern
    included do
      has_one :post, as: :item
      after_create do
        create_post user: author
      end

      after_update do
        post.touch!
      end
    end
  end

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
