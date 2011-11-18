require 'hubruby'

class User < ActiveRecord::Base
  class << self
    attr_accessor :organization

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

    def org_member?(login); !!org_member(login); end

    def org_member(login)
      org_members.detect {|member| member.login == login }
    end

    def org_members
      return @members if @members
      @members = GitHub.organization_public_members(organization)
    end
  end

  validates :uid, :provider, :nickname, presence: true
  validate :user_is_org_member

  before_create :assign_gravatar, if:->(u) { u.provider == 'github' }

  private

  # XXX i18n
  def user_is_org_member
    unless self.class.org_member?(nickname)
      if u = ENV['RECRUITING_URI']
        errors.add(:base, "You are\'nt #{self.class.organization} member. Send your resume to #{u}.")
      else
        errors.add(:base, "You are\'nt #{self.class.organization} member.")
      end
    end
  end

  def assign_gravatar
    mbr = self.class.org_member(nickname)
    self.gravatar = mbr.gravatar_id
  end
end
