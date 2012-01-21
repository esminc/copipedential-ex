class Filetype < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  scope :ordered, order("(SELECT COUNT(*) FROM snippets sn WHERE sn.filetype_id = #{quoted_table_name}.id) DESC")
end
