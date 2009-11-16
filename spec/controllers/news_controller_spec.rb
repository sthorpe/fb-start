require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewsController do

  def mock_news(stubs={})
    @mock_news ||= mock_model(News, stubs)
  end

  describe "GET index" do
    it "assigns all news as @news" do
      News.stub!(:find).with(:all).and_return([mock_news])
      get :index
      assigns[:news].should == [mock_news]
    end
  end

  describe "GET show" do
    it "assigns the requested news as @news" do
      News.stub!(:find).with("37").and_return(mock_news)
      get :show, :id => "37"
      assigns[:news].should equal(mock_news)
    end
  end

  describe "GET new" do
    it "assigns a new news as @news" do
      News.stub!(:new).and_return(mock_news)
      get :new
      assigns[:news].should equal(mock_news)
    end
  end

  describe "GET edit" do
    it "assigns the requested news as @news" do
      News.stub!(:find).with("37").and_return(mock_news)
      get :edit, :id => "37"
      assigns[:news].should equal(mock_news)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created news as @news" do
        News.stub!(:new).with({'these' => 'params'}).and_return(mock_news(:save => true))
        post :create, :news => {:these => 'params'}
        assigns[:news].should equal(mock_news)
      end

      it "redirects to the created news" do
        News.stub!(:new).and_return(mock_news(:save => true))
        post :create, :news => {}
        response.should redirect_to(news_url(mock_news))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved news as @news" do
        News.stub!(:new).with({'these' => 'params'}).and_return(mock_news(:save => false))
        post :create, :news => {:these => 'params'}
        assigns[:news].should equal(mock_news)
      end

      it "re-renders the 'new' template" do
        News.stub!(:new).and_return(mock_news(:save => false))
        post :create, :news => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested news" do
        News.should_receive(:find).with("37").and_return(mock_news)
        mock_news.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :news => {:these => 'params'}
      end

      it "assigns the requested news as @news" do
        News.stub!(:find).and_return(mock_news(:update_attributes => true))
        put :update, :id => "1"
        assigns[:news].should equal(mock_news)
      end

      it "redirects to the news" do
        News.stub!(:find).and_return(mock_news(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(news_url(mock_news))
      end
    end

    describe "with invalid params" do
      it "updates the requested news" do
        News.should_receive(:find).with("37").and_return(mock_news)
        mock_news.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :news => {:these => 'params'}
      end

      it "assigns the news as @news" do
        News.stub!(:find).and_return(mock_news(:update_attributes => false))
        put :update, :id => "1"
        assigns[:news].should equal(mock_news)
      end

      it "re-renders the 'edit' template" do
        News.stub!(:find).and_return(mock_news(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested news" do
      News.should_receive(:find).with("37").and_return(mock_news)
      mock_news.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the news list" do
      News.stub!(:find).and_return(mock_news(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(news_url)
    end
  end

end
