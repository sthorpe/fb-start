require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news/index.html.erb" do
  include NewsHelper

  before(:each) do
    assigns[:news] = [
      stub_model(News),
      stub_model(News)
    ]
  end

  it "renders a list of news" do
    render
  end
end
