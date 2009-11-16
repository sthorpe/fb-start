require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/feeds/show.html.erb" do
  include FeedsHelper
  before(:each) do
    assigns[:feeds] = @feeds = stub_model(Feeds,
      :url => "value for url",
      :location => "value for location"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ url/)
    response.should have_text(/value\ for\ location/)
  end
end
