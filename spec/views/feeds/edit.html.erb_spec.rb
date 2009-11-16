require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/feeds/edit.html.erb" do
  include FeedsHelper

  before(:each) do
    assigns[:feeds] = @feeds = stub_model(Feeds,
      :new_record? => false,
      :url => "value for url",
      :location => "value for location"
    )
  end

  it "renders the edit feeds form" do
    render

    response.should have_tag("form[action=#{feeds_path(@feeds)}][method=post]") do
      with_tag('input#feeds_url[name=?]', "feeds[url]")
      with_tag('input#feeds_location[name=?]', "feeds[location]")
    end
  end
end
