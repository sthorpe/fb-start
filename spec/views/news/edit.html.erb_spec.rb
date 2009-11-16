require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news/edit.html.erb" do
  include NewsHelper

  before(:each) do
    assigns[:news] = @news = stub_model(News,
      :new_record? => false
    )
  end

  it "renders the edit news form" do
    render

    response.should have_tag("form[action=#{news_path(@news)}][method=post]") do
    end
  end
end
