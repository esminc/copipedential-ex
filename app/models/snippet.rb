class Snippet < ActiveRecord::Base
  validates_presence_of :body
  belongs_to :author, class_name: 'User'

  has_many :mentions
  has_many :mentioneds, through: :mentions

  scope :recent, ->(*arg) do
    o = order("#{quoted_table_name}.updated_at DESC")
    (limit = arg.first) ? o.limit(limit.to_i) : o
  end

  def assumed_filetype(if_none = :text)
    filetype.presence || if_none
  end

  def title
    [name, description].reject(&:blank?).join(' - ').presence || body.truncate(20)
  end

  def number
    "copipe:#{id}"
  end
end
