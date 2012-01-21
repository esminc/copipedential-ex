require 'spec_helper'

describe Filetype do
  describe 'used via snippet#rendered_body ' do
    subject { snippet.rendered_body }

    context 'render if renderable and has processor' do
      let(:filetype) { Filetype.create!(name: 'markdown', renderable: true) }
      let(:snippet) { Fabricate(:user).snippets.build(body: '# hi', filetype: filetype) }

      it { should == "<h1>hi</h1>\n" }
    end

    context 'render but noop if renderable without processor' do
      let(:filetype) { Filetype.create!(name: 'Plain Text', renderable: true) }
      let(:snippet) { Fabricate(:user).snippets.build(body: '# hi', filetype: filetype) }

      it { should == "# hi" }
    end

    context 'do nothing unless renderable' do
      let(:filetype) { Filetype.create!(name: 'ruby') }
      let(:snippet) { Fabricate(:user).snippets.build(body: 'p :hi', filetype: filetype) }

      it { should == snippet.body }
    end
  end
end
