require 'spec_helper'

User.organization = 'esminc'

describe User do

  describe '.org_member?' do
    context 'real API access', external: true do
      specify { User.org_member?('moro').should be_true }
    end
  end

  describe '.create callbacks' do
    let(:user) { User.create_from_auth_hash(provider: 'github', uid: 3419, info:{nickname: 'moro', name: 'MOROHASHI Kyosuke'}) }
    subject &:user

    before do
      User.stub!(:org_members) { [moro_offline] }
      user.save!
    end

    its(:nickname) { should == 'moro' }
    its(:gravatar) { should == '70e13d9877054026fda46d5a5b53a236' }
  end

  let(:moro_offline) do
    GitHub::User.from_hash({
      :type=>"User",
      :public_repos=>38,
      :location=>"Tokyo/Japan",
      :company=>"Eiwa System Management Inc.",
      :email=>"moronatural@gmail.com",
      :following=>27,
      :blog=>"http://d.hatena.ne.jp/moro/",
      :hireable=>false,
      :gravatar_id=>"70e13d9877054026fda46d5a5b53a236",
      :bio=>nil,
      :avatar_url=>"https://secure.gravatar.com/avatar/70e13d9877054026fda46d5a5b53a236?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
      :followers=>99,
      :html_url=>"https://github.com/moro",
      :url=>"https://api.github.com/users/moro",
      :login=>"moro",
      :created_at=>"2008-03-19T07:35:34Z",
      :name=>"MOROHASHI Kyosuke",
      :id=>3419,
      :public_gists=>62,
    })
  end
end
__END__
?#<GitHub::User gravatar_id="79252a03c011dffc5afdcbf941d1f952", avatar_url="https://secure.gravatar.com/avatar/79252a03c011dffc5afdcbf941d1f952?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png", url="https://api.github.com/users/tmori", login="tmori", id=164193>, #<GitHub::User gravatar_id="f966e93db0fbaf3aa07f7df5fa136933", avatar_url="https://secure.gravatar.com/avatar/f966e93db0fbaf3aa07f7df5fa136933?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png", url="https://api.github.com/users/ursm", login="ursm", id=7548>, 
