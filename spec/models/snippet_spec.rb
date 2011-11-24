require 'spec_helper'

describe Snippet do
  # XXX
  before do
    Hook.default_url_options = {host: 'copipedential.example.com', protocol: 'https'}
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
end

