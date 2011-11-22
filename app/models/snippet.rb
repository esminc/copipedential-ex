class Snippet < ActiveRecord::Base
  validates_presence_of :body
  belongs_to :author, class_name: 'User'

  def assumed_filetype(if_none = :text)
    filetype.presence || if_none
  end

  def title
    if name || description
      [name, description].compact.join(' - ')
    else
      "#{body.slice(0,20)}"
    end
  end
end
