class LineItemsController < ApplicationController
  load_and_authorize_resource
  
  # GET /line_items
  # GET /line_items.xml
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.xml
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.xml
  def create
    @cart = current_user.cart
    @line_item = @cart.line_items.build(params[:line_item]) 
    
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(root_path, :notice => 'Course added to cart') }
        format.js { @current_item = @line_item }
        format.xml  { render :xml => @line_item, :status => :created, :location => @line_item }
      else
        format.html { redirect_to(root_path, :notice => 'You\'ve already added that course to your cart')}
        format.js   { render courses_path } 
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.xml
  def update

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to(@line_item, :notice => 'Line item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.xml
  def destroy
    @user = current_user
    @course_id = @line_item.course.id
    @line_item.destroy
    @cart = @user.cart

    respond_to do |format|
      format.html { redirect_to(root_path) }
      format.js
      format.xml  { head :ok }
    end
  end
end
