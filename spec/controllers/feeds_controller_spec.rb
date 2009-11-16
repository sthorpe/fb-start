require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FeedsController do

  def mock_feeds(stubs={})
    @mock_feeds ||= mock_model(Feeds, stubs)
  end

  describe "GET index" do
    it "assigns all feeds as @feeds" do
      Feeds.stub!(:find).with(:all).and_return([mock_feeds])
      get :index
      assigns[:feeds].should == [mock_feeds]
    end
  end

  describe "GET show" do
    it "assigns the requested feeds as @feeds" do
      Feeds.stub!(:find).with("37").and_return(mock_feeds)
      get :show, :id => "37"
      assigns[:feeds].should equal(mock_feeds)
    end
  end

  describe "GET new" do
    it "assigns a new feeds as @feeds" do
      Feeds.stub!(:new).and_return(mock_feeds)
      get :new
      assigns[:feeds].should equal(mock_feeds)
    end
  end

  describe "GET edit" do
    it "assigns the requested feeds as @feeds" do
      Feeds.stub!(:find).with("37").and_return(mock_feeds)
      get :edit, :id => "37"
      assigns[:feeds].should equal(mock_feeds)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created feeds as @feeds" do
        Feeds.stub!(:new).with({'these' => 'params'}).and_return(mock_feeds(:save => true))
        post :create, :feeds => {:these => 'params'}
        assigns[:feeds].should equal(mock_feeds)
      end

      it "redirects to the created feeds" do
        Feeds.stub!(:new).and_return(mock_feeds(:save => true))
        post :create, :feeds => {}
        response.should redirect_to(feed_url(mock_feeds))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved feeds as @feeds" do
        Feeds.stub!(:new).with({'these' => 'params'}).and_return(mock_feeds(:save => false))
        post :create, :feeds => {:these => 'params'}
        assigns[:feeds].should equal(mock_feeds)
      end

      it "re-renders the 'new' template" do
        Feeds.stub!(:new).and_return(mock_feeds(:save => false))
        post :create, :feeds => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested feeds" do
        Feeds.should_receive(:find).with("37").and_return(mock_feeds)
        mock_feeds.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :feeds => {:these => 'params'}
      end

      it "assigns the requested feeds as @feeds" do
        Feeds.stub!(:find).and_return(mock_feeds(:update_attributes => true))
        put :update, :id => "1"
        assigns[:feeds].should equal(mock_feeds)
      end

      it "redirects to the feeds" do
        Feeds.stub!(:find).and_return(mock_feeds(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(feed_url(mock_feeds))
      end
    end

    describe "with invalid params" do
      it "updates the requested feeds" do
        Feeds.should_receive(:find).with("37").and_return(mock_feeds)
        mock_feeds.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :feeds => {:these => 'params'}
      end

      it "assigns the feeds as @feeds" do
        Feeds.stub!(:find).and_return(mock_feeds(:update_attributes => false))
        put :update, :id => "1"
        assigns[:feeds].should equal(mock_feeds)
      end

      it "re-renders the 'edit' template" do
        Feeds.stub!(:find).and_return(mock_feeds(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested feeds" do
      Feeds.should_receive(:find).with("37").and_return(mock_feeds)
      mock_feeds.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the feeds list" do
      Feeds.stub!(:find).and_return(mock_feeds(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(feeds_url)
    end
  end

end
