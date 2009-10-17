require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CategoriesController do

  def mock_categories(stubs={})
    @mock_categories ||= mock_model(Categories, stubs)
  end

  describe "GET index" do
    it "assigns all categories as @categories" do
      Categories.stub!(:find).with(:all).and_return([mock_categories])
      get :index
      assigns[:categories].should == [mock_categories]
    end
  end

  describe "GET show" do
    it "assigns the requested categories as @categories" do
      Categories.stub!(:find).with("37").and_return(mock_categories)
      get :show, :id => "37"
      assigns[:categories].should equal(mock_categories)
    end
  end

  describe "GET new" do
    it "assigns a new categories as @categories" do
      Categories.stub!(:new).and_return(mock_categories)
      get :new
      assigns[:categories].should equal(mock_categories)
    end
  end

  describe "GET edit" do
    it "assigns the requested categories as @categories" do
      Categories.stub!(:find).with("37").and_return(mock_categories)
      get :edit, :id => "37"
      assigns[:categories].should equal(mock_categories)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created categories as @categories" do
        Categories.stub!(:new).with({'these' => 'params'}).and_return(mock_categories(:save => true))
        post :create, :categories => {:these => 'params'}
        assigns[:categories].should equal(mock_categories)
      end

      it "redirects to the created categories" do
        Categories.stub!(:new).and_return(mock_categories(:save => true))
        post :create, :categories => {}
        response.should redirect_to(category_url(mock_categories))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved categories as @categories" do
        Categories.stub!(:new).with({'these' => 'params'}).and_return(mock_categories(:save => false))
        post :create, :categories => {:these => 'params'}
        assigns[:categories].should equal(mock_categories)
      end

      it "re-renders the 'new' template" do
        Categories.stub!(:new).and_return(mock_categories(:save => false))
        post :create, :categories => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested categories" do
        Categories.should_receive(:find).with("37").and_return(mock_categories)
        mock_categories.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :categories => {:these => 'params'}
      end

      it "assigns the requested categories as @categories" do
        Categories.stub!(:find).and_return(mock_categories(:update_attributes => true))
        put :update, :id => "1"
        assigns[:categories].should equal(mock_categories)
      end

      it "redirects to the categories" do
        Categories.stub!(:find).and_return(mock_categories(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(category_url(mock_categories))
      end
    end

    describe "with invalid params" do
      it "updates the requested categories" do
        Categories.should_receive(:find).with("37").and_return(mock_categories)
        mock_categories.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :categories => {:these => 'params'}
      end

      it "assigns the categories as @categories" do
        Categories.stub!(:find).and_return(mock_categories(:update_attributes => false))
        put :update, :id => "1"
        assigns[:categories].should equal(mock_categories)
      end

      it "re-renders the 'edit' template" do
        Categories.stub!(:find).and_return(mock_categories(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested categories" do
      Categories.should_receive(:find).with("37").and_return(mock_categories)
      mock_categories.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the categories list" do
      Categories.stub!(:find).and_return(mock_categories(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(categories_url)
    end
  end

end
