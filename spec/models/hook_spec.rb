require 'spec_helper'

describe Hook do
  before do
    Hook::Message.default_url_options = {host: 'copipedential.example.com', protocol: 'https'}
  end

  describe 'Message' do
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
end

