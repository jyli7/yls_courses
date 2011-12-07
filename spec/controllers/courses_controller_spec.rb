require 'spec_helper'

describe CoursesController do
  render_views

  def valid_attributes
    {}
  end

  describe "GET index" do
    it "should be successful" do 
      get 'index'
      response.should be_success
    end
  end

end
