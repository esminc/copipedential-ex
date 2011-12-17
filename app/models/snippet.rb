class Snippet < ActiveRecord::Base
  validates_presence_of :body
  belongs_to :author, class_name: 'User'
  belongs_to :filetype

  has_many :mentions
  has_many :mentioneds, through: :mentions

  scope :recent, ->(limit = nil) do
    o = order("#{quoted_table_name}.updated_at DESC")
    limit ? o.limit(limit.to_i) : o
  end

  include ::Hook::MentionHook

  def assumed_filetype(if_none = :text)
    filetype.try(:name) || if_none
  end

  def title
    [name, description].reject(&:blank?).join(' - ').presence || body.truncate(20)
  end

  def code
    "copipe:#{id}"
  end
end
