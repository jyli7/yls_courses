class ApplicationController < ActionController::Base
  helper_method :sort_column, :sort_direction
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
    root_path
  end
  
  private 
  
  def current_cart
    Cart.find(:user_id)
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    cart
  end
end
