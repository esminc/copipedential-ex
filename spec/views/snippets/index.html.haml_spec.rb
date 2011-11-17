require 'spec_helper'

describe "snippets/index.html.haml" do
  before(:each) do
    assign(:snippets, [
      stub_model(Snippet,
        :author => "Author",
        :title => "Title",
        :body => "MyText",
        :filetype => "Filetype"
      ),
      stub_model(Snippet,
        :author => "Author",
        :title => "Title",
        :body => "MyText",
        :filetype => "Filetype"
      )
    ])
  end

  it "renders a list of snippets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Filetype".to_s, :count => 2
  end
end
