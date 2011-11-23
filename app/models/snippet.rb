class Snippet < ActiveRecord::Base
  validates_presence_of :body
  belongs_to :author, class_name: 'User'

  has_many :mentions
  has_many :mentioneds, through: :mentions

  def assumed_filetype(if_none = :text)
    filetype.presence || if_none
  end

  def number
    "copipe:#{id}"
  end
end
