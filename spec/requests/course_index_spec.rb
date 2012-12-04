require 'spec_helper'

describe "CourseIndex" do
  it "tells the user the last time the data was updated" do
    visit('/')
    page.should have_content('last updated')
  end
  
  it ""
end
