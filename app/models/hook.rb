class Hook
  include Rails.application.routes.url_helpers

  module MentionHook
    extend ActiveSupport::Concern
    included do
      after_save do |record|
        return true if record.mentions.empty?
        ::Hook.mention(record)
      end
    end
  end

  def self.mention(snippet)
    hook(new(snippet).mention)
  end

  def self.hook(message)
    return unless enabled?
  end

  def self.enabled?; !!ENV['ENDPOINT'] ; end

  def initialize(snippet)
    @snippet = snippet
  end

  def mention
    verb = @snippet.id_was.nil? ? 'pasted' : 'updated'
    receivers = @snippet.mentioneds.map(&:nickname).sort.join(' ')

    "#{receivers}: #{author_nickname} #{verb} snippet for you -- #{permalink}"
  end

  private

  def author_nickname
    @snippet.author.nickname
  end

  def permalink
    url_for(@snippet)
  end
end
