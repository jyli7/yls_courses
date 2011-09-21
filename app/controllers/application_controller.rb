class ApplicationController < ActionController::Base
  helper_method :sort_column, :sort_direction
  protect_from_forgery
end
