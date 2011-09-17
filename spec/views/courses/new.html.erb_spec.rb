require 'spec_helper'

describe "courses/new.html.erb" do
  before(:each) do
    assign(:course, stub_model(Course,
      :name => "MyString",
      :number => "MyString",
      :instructor => "MyString",
      :room => "MyString",
      :day => "MyString",
      :units => "MyString",
      :time => "MyString"
    ).as_new_record)
  end

  it "renders new course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => courses_path, :method => "post" do
      assert_select "input#course_name", :name => "course[name]"
      assert_select "input#course_number", :name => "course[number]"
      assert_select "input#course_instructor", :name => "course[instructor]"
      assert_select "input#course_room", :name => "course[room]"
      assert_select "input#course_day", :name => "course[day]"
      assert_select "input#course_units", :name => "course[units]"
      assert_select "input#course_time", :name => "course[time]"
    end
  end
end
