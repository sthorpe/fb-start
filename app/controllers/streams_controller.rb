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
  
  def send_email
    @stream = Stream.find(params[:id])
    user_ids = [params[:uid].to_i]
    facebook_session.user.notifications_sendEmail(user_ids,"Check this out!", @stream.name)
    flash[:notice] = "Message sent."
    redirect_to :back
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
    @streams = @stream.sort_by_categories_and_friends(params, facebook_session)
    
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
        begin
          #FacebookerPublisher.deliver_posted_action(facebook_session.user, @stream)
          facebook_session.user.publish_to(facebook_session.user, :message => @stream.name.to_s)
        rescue
        end
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
