class Filetype < ActiveRecord::Base
  validates_presence_of :name
  scope :ordered, order("#{quoted_table_name}.id ASC")
end
