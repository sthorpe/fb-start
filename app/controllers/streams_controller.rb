class StreamsController < ApplicationController
  before_filter :login_required, :only => [ :new ]
  
  
  # GET /streams
  # GET /streams.xml
  def index
    @streams = Stream.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @streams }
    end
  end
  
  def search_streams
    @streams = Stream.search params 
  end

  # GET /streams/1
  # GET /streams/1.xml
  def show
    @stream = Stream.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stream }
    end
  end

  # GET /streams/new
  # GET /streams/new.xml
  def new
    @stream = Stream.new
    @categories = Categories.find(:all, :limit => 6)
    
    if facebook_session
      facebook_user = facebook_session.user
      @tags = facebook_user.interests
      @friends = facebook_user.friends.to_a[0..3]
    end
    
    if params[:categories_id] 
      if params[:categories_id] == "1"
        @streams = Stream.all
      else
        @streams = Stream.find(:all, :conditions=>["categories_id IN (#{params[:categories_id]})" ])
      end
    else 
      @streams = Stream.all
    end
    
    if params[:fb_friends] == "true" && facebook_session
      @streams = Stream.find_friends_streams(facebook_session)
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stream }
    end
  end

  # GET /streams/1/edit
  def edit
    @stream = Stream.find(params[:id])
  end

  # POST /streams
  # POST /streams.xml
  def create
    @stream = Stream.new(params[:stream])
    @categories = Categories.find(:all, :limit => 6)
    @streams = Stream.all

    respond_to do |format|
      if @stream.save
        current_user.new_stream(@stream)
        flash[:notice] = 'Stream was successfully created.'
        format.html { redirect_to new_stream_path }
        format.xml  { render :xml => @stream, :status => :created, :location => @stream }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stream.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /streams/1
  # PUT /streams/1.xml
  def update
    @stream = Stream.find(params[:id])

    respond_to do |format|
      if @stream.update_attributes(params[:stream])
        flash[:notice] = 'Stream was successfully updated.'
        format.html { redirect_to(@stream) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stream.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /streams/1
  # DELETE /streams/1.xml
  def destroy
    @stream = Stream.find(params[:id])
    @stream.destroy

    respond_to do |format|
      format.html { redirect_to(new_stream_url) }
      format.xml  { head :ok }
    end
  end
end
