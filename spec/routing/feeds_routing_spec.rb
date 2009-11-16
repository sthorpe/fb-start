require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FeedsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "feeds", :action => "index").should == "/feeds"
    end

    it "maps #new" do
      route_for(:controller => "feeds", :action => "new").should == "/feeds/new"
    end

    it "maps #show" do
      route_for(:controller => "feeds", :action => "show", :id => "1").should == "/feeds/1"
    end

    it "maps #edit" do
      route_for(:controller => "feeds", :action => "edit", :id => "1").should == "/feeds/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "feeds", :action => "create").should == {:path => "/feeds", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "feeds", :action => "update", :id => "1").should == {:path =>"/feeds/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "feeds", :action => "destroy", :id => "1").should == {:path =>"/feeds/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/feeds").should == {:controller => "feeds", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/feeds/new").should == {:controller => "feeds", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/feeds").should == {:controller => "feeds", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/feeds/1").should == {:controller => "feeds", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/feeds/1/edit").should == {:controller => "feeds", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/feeds/1").should == {:controller => "feeds", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/feeds/1").should == {:controller => "feeds", :action => "destroy", :id => "1"}
    end
  end
end
