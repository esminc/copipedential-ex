class Picture < ActiveRecord::Base

  include Post::CallbackMixin

  belongs_to :author, class_name: 'User'
  validates_presence_of :key
  attr_accessible :name, :description

  def raw_data=(raw)
    raw = decode64data(raw) if raw.first(5) == 'data:'
    self.key = storage.put(StringIO.new(raw))
  end

  def almost_new?
    created_at == updated_at && (created_at > 60.minutes.ago)
  end

  def code
    "pict:#{id}"
  end

  def raw_data
    storage.get(key)
  end

  def clean_data
    storage.delete(key)
  end

  def storage
    @storage ||= GyomuRuby::AWS::FileBucket.new("copipedential-#{Rails.env}")
  end

  private

  def decode64data(data)
    media, payload = data.split(':', 2).last.split(';', 2)
    payload.sub!(/^base64,/i, '')
    Base64.decode64(payload)
  end
end
