class FeedsController < ApplicationController
  # GET /feeds
  # GET /feeds.xml
  def index
    @feeds = Feeds.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feeds }
    end
  end

  # GET /feeds/1
  # GET /feeds/1.xml
  def show
    @feeds = Feeds.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feeds }
    end
  end

  # GET /feeds/new
  # GET /feeds/new.xml
  def new
    @feeds = Feeds.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feeds }
    end
  end

  # GET /feeds/1/edit
  def edit
    @feeds = Feeds.find(params[:id])
  end

  # POST /feeds
  # POST /feeds.xml
  def create
    @feeds = Feeds.new(params[:feeds])

    respond_to do |format|
      if @feeds.save
        flash[:notice] = 'Feeds was successfully created.'
        format.html { redirect_to(@feeds) }
        format.xml  { render :xml => @feeds, :status => :created, :location => @feeds }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feeds.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feeds/1
  # PUT /feeds/1.xml
  def update
    @feeds = Feeds.find(params[:id])

    respond_to do |format|
      if @feeds.update_attributes(params[:feeds])
        flash[:notice] = 'Feeds was successfully updated.'
        format.html { redirect_to(@feeds) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feeds.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.xml
  def destroy
    @feeds = Feeds.find(params[:id])
    @feeds.destroy

    respond_to do |format|
      format.html { redirect_to(feeds_url) }
      format.xml  { head :ok }
    end
  end
end
