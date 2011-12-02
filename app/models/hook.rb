# coding: utf-8
require 'net/https'
require 'yaml'

class Hook < ActiveRecord::Base
  module MentionHook
    extend ActiveSupport::Concern
    included do
      after_save do |record|
        return true if record.mentions.empty?
        ::Hook.mention(record)
      end
    end
  end

  BACKENDS = {
    # TODO test
    webpost: ->(message, config) {
      uri = URI(config[:endpoint])
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE # FIXME
      end

      req = Net::HTTP::Post.new(uri.request_uri)
      req.basic_auth(uri.user, uri.password) if uri.user
      req.set_form_data(config[:post_key] => message)
      http.start{|con| con.request(req) }
    }
  }

  def self.mention(snippet)
    hook(Message.new(snippet).mention)
  end

  def self.hook(message)
    active.each {|hook| hook.hook(message) }
  end

  validates :name, presence: true
  validates :engine, presence: true
  validate  :config_is_valid_yaml

  scope :active, where(active: true)

  def hook(message)
    engine.try(:call, message, YAML.load(config))
  end

  def engine
    BACKENDS[backend.to_sym]
  end

  private

  def config_is_valid_yaml
    YAML.load(config)
  rescue
    errors.add(:config, 'はYAMLを手書きしてください')
  end
end
