require 'spec_helper'

describe Post do
  describe 'eager loadable polymorphic association' do
    include_context 'a [user] will paste a [snippet] w/ mentioning to [mentioned]'
    let(:picture) { Fabricate(:picture, author: user) }
    before do
      user.posts.create!(item: snippet)
      user.posts.create!(item: picture)

      @loaded_posts = Post.with_items.order(:id).all
      ActiveRecord::Base.connection.should_not_receive(:select_all)
    end

    specify { @loaded_posts.map(&:item).should == [snippet, picture] }
  end
end

