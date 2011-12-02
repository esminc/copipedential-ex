class Hook
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
    hook(Message.new(snippet).mention)
  end

  def self.hook(message)
    return unless enabled?
  end

  def self.enabled?
    !!ENV['ENDPOINT']
  end
end
