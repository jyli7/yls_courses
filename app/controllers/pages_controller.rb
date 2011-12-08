require 'net/https'
require 'uri'

class PagesController < ApplicationController
  def about
    @title = "About"
  end
  
  def faq
    @faq = "About"
  end  
  
  def activate_ratings
    @ticket = params[:ticket]
    callback_url ="http://www.ylsclassaction.com/activate_ratings_view"
    uri = URI.parse("https://secure.its.yale.edu/cas/serviceValidate?ticket=#{@ticket}&service=#{callback_url}")
    
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http| 
      http.request Net::HTTP::Get.new(uri.request_uri)
    end

    if response.body.include? "INVALID_TICKET"
    else
      current_user.update_attribute :ratings_authorized, true
    end
    redirect_to("http://www.ylsclassaction.com", :notice => "Ratings activated!")
  end
end
