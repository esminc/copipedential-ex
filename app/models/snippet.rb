class Snippet < ActiveRecord::Base
  validates_presence_of :body
  def assumed_filetype(if_none = :text)
    filetype.presence || CodeRay::FileType.fetch(title) rescue if_none
  end
end
