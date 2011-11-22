require 'hubruby'

class User < ActiveRecord::Base
  class NotOrgMember < RuntimeError
  end

  class << self
    def organization
      ENV['ORGANIZATION'] || 'esminc'
    end

    def find_by_auth_hash(auth_hash)
      where(auth_hash.slice(:provider, :uid)).first
    end

    def build_from_auth_hash(auth_hash)
      nickname = if auth_hash.provider == 'github'
          auth_hash[:info][:nickname]
        else
          auth_hash[:info][:nickname] || auth_hash[:info][:name]
        end

      new(auth_hash.slice(:provider, :uid).merge(nickname: nickname))
    end

    def verify_org_member!(user)
      if org_member?(user.nickname)
        if user.new_record?
          user.authorized_at = Time.now
        else
          user.update_attribute :authorized_at,  Time.now
        end
      else
        raise NotOrgMember
      end
    end

    def org_member?(login); !!org_member(login); end

    def org_member(login)
      org_members.detect {|member| member.login == login }
    end

    def org_members
      with_caching('user.org_member', expires_in: 60.minutes.to_i) do
        GitHub.organization_public_members(organization)
      end
    end

    def with_caching(key, options = {}, &if_not_hit)
      key = [Rails.env, key].join('.')
      unless Rails.cache.exist?(key)
        Rails.cache.write(key, if_not_hit.call(key), options)
      end
      Rails.cache.read(key)
    end
  end

  has_many :snippets, foreign_key: :author_id
  has_many :mentions, foreign_key: :mentioned_id
  has_many :mentioned_snippets, through: :mentions, source: 'snippet'

  validates :uid, :provider, :nickname, presence: true
  validates_uniqueness_of :uid, scope: :provider
  validate :user_is_org_member, if:->(u) { u.provider == 'github' }

  before_create :assign_gravatar, if:->(u) { u.provider == 'github' }

  scope :alphabetical_order, order("#{quoted_table_name}.nickname ASC")

  private

  # XXX i18n
  def user_is_org_member
    begin
      self.class.verify_org_member!(self)
    rescue NotOrgMember
      msg = "You are\'nt #{self.class.organization} member."
      if u = ENV['RECRUITING_URI']
        msg << " Send your resume to #{u}."
      end
      errors.add(:base, msg)
    end
  end

  def assign_gravatar
    mbr = self.class.org_member(nickname)
    self.gravatar = mbr.gravatar_id
  end
end
