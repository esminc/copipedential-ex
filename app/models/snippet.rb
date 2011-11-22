class Snippet < ActiveRecord::Base
  validates_presence_of :body
  belongs_to :author, class_name: 'User'

  def assumed_filetype(if_none = :text)
    filetype.presence || if_none
  end

  def title
    [name, description].reject(&:blank?).join(' - ').presence || body.truncate(20)
  end
end
