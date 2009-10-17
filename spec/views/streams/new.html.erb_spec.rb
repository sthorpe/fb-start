require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/streams/new.html.erb" do
  include StreamsHelper

  before(:each) do
    assigns[:stream] = stub_model(Stream,
      :new_record? => true,
      :name => "value for name",
      :user_id => 1
    )
  end

  it "renders new stream form" do
    render

    response.should have_tag("form[action=?][method=post]", streams_path) do
      with_tag("input#stream_name[name=?]", "stream[name]")
      with_tag("input#stream_user_id[name=?]", "stream[user_id]")
    end
  end
end
