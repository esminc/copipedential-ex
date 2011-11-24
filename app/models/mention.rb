class Mention < ActiveRecord::Base
  belongs_to :snippet
  belongs_to :mentioned, class_name: 'User'
end
