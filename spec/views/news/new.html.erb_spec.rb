require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news/new.html.erb" do
  include NewsHelper

  before(:each) do
    assigns[:news] = stub_model(News,
      :new_record? => true
    )
  end

  it "renders new news form" do
    render

    response.should have_tag("form[action=?][method=post]", news_path) do
    end
  end
end
