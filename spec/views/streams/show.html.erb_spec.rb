require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/streams/show.html.erb" do
  include StreamsHelper
  before(:each) do
    assigns[:stream] = @stream = stub_model(Stream,
      :name => "value for name",
      :user_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/1/)
  end
end
