require 'spec_helper'

describe "courses/show.html.erb" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :name => "Name",
      :number => "Number",
      :instructor => "Instructor",
      :room => "Room",
      :day => "Day",
      :units => "Units",
      :time => "Time"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Number/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Instructor/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Room/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Day/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Units/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Time/)
  end
end
