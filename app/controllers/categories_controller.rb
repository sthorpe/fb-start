class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Categories.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @categories = Categories.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @categories = Categories.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1/edit
  def edit
    @categories = Categories.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    @categories = Categories.new(params[:categories])

    respond_to do |format|
      if @categories.save
        flash[:notice] = 'Categories was successfully created.'
        format.html { redirect_to(@categories) }
        format.xml  { render :xml => @categories, :status => :created, :location => @categories }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @categories.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @categories = Categories.find(params[:id])

    respond_to do |format|
      if @categories.update_attributes(params[:categories])
        flash[:notice] = 'Categories was successfully updated.'
        format.html { redirect_to(@categories) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @categories.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @categories = Categories.find(params[:id])
    @categories.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
end
