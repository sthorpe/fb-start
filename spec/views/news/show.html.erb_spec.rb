require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news/show.html.erb" do
  include NewsHelper
  before(:each) do
    assigns[:news] = @news = stub_model(News)
  end

  it "renders attributes in <p>" do
    render
  end
end
