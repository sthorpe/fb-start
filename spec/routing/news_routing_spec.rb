require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "news", :action => "index").should == "/news"
    end

    it "maps #new" do
      route_for(:controller => "news", :action => "new").should == "/news/new"
    end

    it "maps #show" do
      route_for(:controller => "news", :action => "show", :id => "1").should == "/news/1"
    end

    it "maps #edit" do
      route_for(:controller => "news", :action => "edit", :id => "1").should == "/news/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "news", :action => "create").should == {:path => "/news", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "news", :action => "update", :id => "1").should == {:path =>"/news/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "news", :action => "destroy", :id => "1").should == {:path =>"/news/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/news").should == {:controller => "news", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/news/new").should == {:controller => "news", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/news").should == {:controller => "news", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/news/1").should == {:controller => "news", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/news/1/edit").should == {:controller => "news", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/news/1").should == {:controller => "news", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/news/1").should == {:controller => "news", :action => "destroy", :id => "1"}
    end
  end
end
