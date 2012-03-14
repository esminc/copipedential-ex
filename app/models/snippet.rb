class Snippet < ActiveRecord::Base
  validates_presence_of :body, :author
  belongs_to :author, class_name: 'User'
  belongs_to :filetype

  has_many :mentions
  has_many :mentioneds, through: :mentions

  scope :recent, ->(limit = nil) do
    o = order("#{quoted_table_name}.updated_at DESC")
    limit ? o.limit(limit.to_i) : o
  end
  scope :search, ->(q) do
    q.blank? ? scoped : where('snippets.body LIKE ?', "%#{q}%")
  end

  include ::Hook::MentionHook

  def filetype_name
    filetype.try(:name)
  end
  alias_method :assumed_filetype, :filetype_name

  def title
    [name, description].reject(&:blank?).join(' - ').presence || body.truncate(20)
  end

  def code
    "copipe:#{id}"
  end

  def rendered_body
    filetype.try(:renderable) ? filetype.render(body) : body
  end
end
