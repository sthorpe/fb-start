require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CategoriesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "categories", :action => "index").should == "/categories"
    end

    it "maps #new" do
      route_for(:controller => "categories", :action => "new").should == "/categories/new"
    end

    it "maps #show" do
      route_for(:controller => "categories", :action => "show", :id => "1").should == "/categories/1"
    end

    it "maps #edit" do
      route_for(:controller => "categories", :action => "edit", :id => "1").should == "/categories/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "categories", :action => "create").should == {:path => "/categories", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "categories", :action => "update", :id => "1").should == {:path =>"/categories/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "categories", :action => "destroy", :id => "1").should == {:path =>"/categories/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/categories").should == {:controller => "categories", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/categories/new").should == {:controller => "categories", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/categories").should == {:controller => "categories", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/categories/1").should == {:controller => "categories", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/categories/1/edit").should == {:controller => "categories", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/categories/1").should == {:controller => "categories", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/categories/1").should == {:controller => "categories", :action => "destroy", :id => "1"}
    end
  end
end
