require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StreamsController do

  def mock_stream(stubs={})
    @mock_stream ||= mock_model(Stream, stubs)
  end

  describe "GET index" do
    it "assigns all streams as @streams" do
      Stream.stub!(:find).with(:all).and_return([mock_stream])
      get :index
      assigns[:streams].should == [mock_stream]
    end
  end

  describe "GET show" do
    it "assigns the requested stream as @stream" do
      Stream.stub!(:find).with("37").and_return(mock_stream)
      get :show, :id => "37"
      assigns[:stream].should equal(mock_stream)
    end
  end

  describe "GET edit" do
    it "assigns the requested stream as @stream" do
      Stream.stub!(:find).with("37").and_return(mock_stream)
      get :edit, :id => "37"
      assigns[:stream].should equal(mock_stream)
    end
  end

  describe "POST create" do


    describe "with invalid params" do
      it "assigns a newly created but unsaved stream as @stream" do
        Stream.stub!(:new).with({'these' => 'params'}).and_return(mock_stream(:save => false))
        post :create, :stream => {:these => 'params'}
        assigns[:stream].should equal(mock_stream)
      end

      it "re-renders the 'new' template" do
        Stream.stub!(:new).and_return(mock_stream(:save => false))
        post :create, :stream => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested stream" do
        Stream.should_receive(:find).with("37").and_return(mock_stream)
        mock_stream.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :stream => {:these => 'params'}
      end

      it "assigns the requested stream as @stream" do
        Stream.stub!(:find).and_return(mock_stream(:update_attributes => true))
        put :update, :id => "1"
        assigns[:stream].should equal(mock_stream)
      end

      it "redirects to the stream" do
        Stream.stub!(:find).and_return(mock_stream(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(stream_url(mock_stream))
      end
    end

    describe "with invalid params" do
      it "updates the requested stream" do
        Stream.should_receive(:find).with("37").and_return(mock_stream)
        mock_stream.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :stream => {:these => 'params'}
      end

      it "assigns the stream as @stream" do
        Stream.stub!(:find).and_return(mock_stream(:update_attributes => false))
        put :update, :id => "1"
        assigns[:stream].should equal(mock_stream)
      end

      it "re-renders the 'edit' template" do
        Stream.stub!(:find).and_return(mock_stream(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested stream" do
      Stream.should_receive(:find).with("37").and_return(mock_stream)
      mock_stream.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  end

end
