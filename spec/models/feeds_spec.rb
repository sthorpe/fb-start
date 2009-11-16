require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Feeds do
  before(:each) do
    @valid_attributes = {
      :url => "value for url",
      :location => "value for location"
    }
  end

  it "should create a new instance given valid attributes" do
    Feeds.create!(@valid_attributes)
  end
end
