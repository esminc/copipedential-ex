class Snippet < ActiveRecord::Base
  def assumed_filetype(if_none = :text)
    filetype.presence || CodeRay::FileType.fetch(title) rescue if_none
  end
end
