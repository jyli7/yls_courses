desc "Fetch law classes"
task :fetch_classes => :environment do 
require 'spreadsheet'
require 'rubygems'

  Spreadsheet.client_encoding = 'UTF-8'

  book = Spreadsheet.open '/Users/jimmyli/rails_projects/grocery_helper/public/data/YLS_Classes.xls'
  sheet1 = book.worksheet 'Sheet1'

  name_array = [] # for names
  sheet1.each 3 do |row|
    name_array << row[0] 
  end
  
  for name in name_array
    Course.create!(:name => name)
  end 

  cnum_array = [] # for course numbers
  sheet1.each 3 do |row|
    cnum_array << row[1] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :number, cnum_array[count]
    count += 1
  end 

  cnum_array = [] # for instructors
  sheet1.each 3 do |row|
    cnum_array << row[2] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :instructor, cnum_array[count]
    count += 1
  end

  cnum_array = [] # for day
  sheet1.each 3 do |row|
    cnum_array << row[3] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :day, cnum_array[count]
    count += 1
  end

  cnum_array = [] # for time
  sheet1.each 3 do |row|
    cnum_array << row[4] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :time, cnum_array[count]
    count += 1
  end


  cnum_array = [] # for room
  sheet1.each 3 do |row|
    cnum_array << row[5] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :room, cnum_array[count]
    count += 1
  end


  cnum_array = [] # for units
  sheet1.each 3 do |row|
    cnum_array << row[6] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :units, cnum_array[count]
    count += 1
  end

  cnum_array = [] # for limitations
  sheet1.each 3 do |row|
    cnum_array << row[7] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :limitations, cnum_array[count]
    count += 1
  end

end 
