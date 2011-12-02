
shared_context 'a [user] will paste a [snippet] w/ mentioning to [mentioned]' do
  let(:user) { Fabricate(:user) }
  let(:mentioned) { Fabricate(:user) }
  let(:snippet) { user.snippets.build(body: 'p :hi', mentioned_ids: [mentioned.id]) }
end

