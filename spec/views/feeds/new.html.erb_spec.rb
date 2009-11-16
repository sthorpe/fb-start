require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/feeds/new.html.erb" do
  include FeedsHelper

  before(:each) do
    assigns[:feeds] = stub_model(Feeds,
      :new_record? => true,
      :url => "value for url",
      :location => "value for location"
    )
  end

  it "renders new feeds form" do
    render

    response.should have_tag("form[action=?][method=post]", feeds_path) do
      with_tag("input#feeds_url[name=?]", "feeds[url]")
      with_tag("input#feeds_location[name=?]", "feeds[location]")
    end
  end
end
