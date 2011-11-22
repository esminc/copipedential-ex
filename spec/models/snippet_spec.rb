require 'spec_helper'

describe Snippet do
  describe 'mention' do
    let(:user) { Fabricate(:user) }
    let(:mentioned) { Fabricate(:user) }
    let(:snippet) { user.snippets.build(body: 'p :hi', mentioned_ids: [mentioned.id]) }

    subject &:snippet

    before do
      snippet.save!
    end

    its('mentioneds.to_a') { should == [mentioned] }
    specify { mentioned.mentioned_snippets.should =~ [snippet] }
  end
end
