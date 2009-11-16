require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/feeds/index.html.erb" do
  include FeedsHelper

  before(:each) do
    assigns[:feeds] = [
      stub_model(Feeds,
        :url => "value for url",
        :location => "value for location"
      ),
      stub_model(Feeds,
        :url => "value for url",
        :location => "value for location"
      )
    ]
  end

  it "renders a list of feeds" do
    render
    response.should have_tag("tr>td", "value for url".to_s, 2)
    response.should have_tag("tr>td", "value for location".to_s, 2)
  end
end
