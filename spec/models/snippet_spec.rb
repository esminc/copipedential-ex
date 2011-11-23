require 'spec_helper'

describe Snippet do
  before do
    Hook.default_url_options = {host: 'copipedential.example.com', protocol: 'https'}
  end

  shared_context 'a [user] will paste a [snippet] w/ mentioning to [mentioned]' do
    let(:user) { Fabricate(:user) }
    let(:mentioned) { Fabricate(:user) }
    let(:snippet) { user.snippets.build(body: 'p :hi', mentioned_ids: [mentioned.id]) }
  end

  describe 'save the snippet, and built valid associations' do
    include_context 'a [user] will paste a [snippet] w/ mentioning to [mentioned]'

    subject &:snippet

    before do
      snippet.save!
    end

    its('mentioneds.to_a') { should == [mentioned] }
    specify { mentioned.mentioned_snippets.should =~ [snippet] }
  end

  describe 'send a valid notification to endpoint' do
    include_context 'a [user] will paste a [snippet] w/ mentioning to [mentioned]'

    let(:new_message) { %r{#{mentioned.nickname}: #{user.nickname} pasted snippet for you -- https://copipedential.example.com/snippets/\d+} }
    let(:updated_message) { %r{#{mentioned.nickname}: #{user.nickname} updated snippet for you -- https://copipedential.example.com/snippets/\d+} }

    specify do
      Hook.should_receive(:hook).with(new_message) { true }
      snippet.save!
    end

    specify do
      Hook.stub!(:hook).with(new_message) { true }
      snippet.save!

      Hook.should_receive(:hook).with(updated_message) { true }
      snippet.body += "\nputs :more"
      snippet.save!
    end
  end
end

