require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have an about page at '/about'" do 
    get '/about'
    response.should be_success
  end

  it "should have an about page at '/about_ratings'" do 
    get '/about_ratings'
    response.should be_success
  end
  
  it "should have an about page at '/faq'" do 
    get '/faq'
    response.should be_success
  end
end
