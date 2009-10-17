require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/streams/index.html.erb" do
  include StreamsHelper

  before(:each) do
    assigns[:streams] = [
      stub_model(Stream,
        :name => "value for name",
        :user_id => 1
      ),
      stub_model(Stream,
        :name => "value for name",
        :user_id => 1
      )
    ]
  end

  it "renders a list of streams" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
