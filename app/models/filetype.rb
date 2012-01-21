class Filetype < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  scope :ordered, order("(SELECT COUNT(*) FROM snippets sn WHERE sn.filetype_id = #{quoted_table_name}.id) DESC")

  cattr_accessor :processors

  self.processors = Hash.new{|h, k| h[k] = ->(body) { body } }
  self.processors['markdown'] = ->(body) { Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(body) }

  def render(body)
    key = name.sub(/\s+/, '_').underscore
    self.class.processors[key].call(body)
  end
end
