require 'spec_helper'

describe "snippets/new.html.haml" do
  before(:each) do
    assign(:snippet, stub_model(Snippet,
      :author => "MyString",
      :title => "MyString",
      :body => "MyText",
      :filetype => "MyString"
    ).as_new_record)
  end

  it "renders new snippet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => snippets_path, :method => "post" do
      assert_select "input#snippet_author", :name => "snippet[author]"
      assert_select "input#snippet_title", :name => "snippet[title]"
      assert_select "textarea#snippet_body", :name => "snippet[body]"
      assert_select "input#snippet_filetype", :name => "snippet[filetype]"
    end
  end
end
