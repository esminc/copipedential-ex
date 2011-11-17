require 'spec_helper'

describe "snippets/show.html.haml" do
  before(:each) do
    @snippet = assign(:snippet, stub_model(Snippet,
      :author => "Author",
      :title => "Title",
      :body => "MyText",
      :filetype => "Filetype"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Author/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Filetype/)
  end
end
