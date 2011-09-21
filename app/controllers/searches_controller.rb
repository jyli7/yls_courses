class SearchesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @searches = Search.all
  end

  def show
    @search_show = Search.find(params[:id])
  end

  def new
    @search = Search.new
    @title = "New Search"
  end

  def create
    @search = Search.new(params[:search])
    $days = params[:days]
    $searchable = 1 
    
    respond_to do |format|  
      if @search.save 
        format.html { redirect_to courses_path, :notice => "Successfully created search."}
        format.js 
      else
        format.html { render :action => 'new' }
      end
    end
  end 

  def edit
    @search = Search.find(params[:id])
  end

  def update
    @search = Search.find(params[:id])
    if @search.update_attributes(params[:search])
      redirect_to @search, :notice  => "Successfully updated search."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @search = Search.find(params[:id])
    @search.destroy
    redirect_to searches_url, :notice => "Successfully destroyed search."
  end
  
  private 
  
    def sort_column
      Course.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
