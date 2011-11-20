class CartsController < ApplicationController
  load_and_authorize_resource
  
  # GET /carts
  # GET /carts.xml
  def index
    # 
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.xml  { render :xml => @carts }
    # end
  end

  # GET /carts/1
  # GET /carts/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cart }
    end 
  end

  # GET /carts/new
  # GET /carts/new.xml
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cart }
    end
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.xml
  def create    
    @cart.user = current_user

    respond_to do |format|
      if @cart.save
        format.html { redirect_to(@cart, :notice => 'Cart was successfully created.') }
        format.xml  { render :xml => @cart, :status => :created, :location => @cart }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.xml
  def update
    if @cart.line_items
      @course_id_array = []
      @cart.line_items.each do |item|
        @course_id_array << item.course.id
        item.destroy
      end
    end 
    @user = current_user
    @cart = @user.cart 

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to(root_path, :notice => 'Cart emptied.') }
        format.js
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.xml
  def destroy
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to(root_path, 
        :notice => 'Your course cart is now empty') }
      format.xml  { head :ok }
    end
  end
end
