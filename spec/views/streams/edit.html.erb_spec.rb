require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/streams/edit.html.erb" do
  include StreamsHelper

  before(:each) do
    assigns[:stream] = @stream = stub_model(Stream,
      :new_record? => false,
      :name => "value for name",
      :user_id => 1
    )
  end

  it "renders the edit stream form" do
    render

    response.should have_tag("form[action=#{stream_path(@stream)}][method=post]") do
      with_tag('input#stream_name[name=?]', "stream[name]")
      with_tag('input#stream_user_id[name=?]', "stream[user_id]")
    end
  end
end
