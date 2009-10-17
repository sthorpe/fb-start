require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StreamsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "streams", :action => "index").should == "/streams"
    end

    it "maps #new" do
      route_for(:controller => "streams", :action => "new").should == "/streams/new"
    end

    it "maps #show" do
      route_for(:controller => "streams", :action => "show", :id => "1").should == "/streams/1"
    end

    it "maps #edit" do
      route_for(:controller => "streams", :action => "edit", :id => "1").should == "/streams/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "streams", :action => "create").should == {:path => "/streams", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "streams", :action => "update", :id => "1").should == {:path =>"/streams/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "streams", :action => "destroy", :id => "1").should == {:path =>"/streams/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/streams").should == {:controller => "streams", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/streams/new").should == {:controller => "streams", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/streams").should == {:controller => "streams", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/streams/1").should == {:controller => "streams", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/streams/1/edit").should == {:controller => "streams", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/streams/1").should == {:controller => "streams", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/streams/1").should == {:controller => "streams", :action => "destroy", :id => "1"}
    end
  end
end
