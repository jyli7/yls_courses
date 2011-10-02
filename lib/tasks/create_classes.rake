desc "Fetch law classes"
task :fetch_classes => :environment do 
require 'spreadsheet'
require 'rubygems'
require 'time'

  Spreadsheet.client_encoding = 'UTF-8'

  book = Spreadsheet.open '/Users/jimmyli/rails_projects/grocery_helper/public/data/YLS_Classes.xls'
  sheet1 = book.worksheet 'Sheet1'
'''
  name_array = [] # for names
  sheet1.each 2 do |row|
    name_array << row[0] 
  end
  
  for name in name_array
    Course.create!(:name => name)
  end 

  cnum_array = [] # for course numbers
  sheet1.each 2 do |row|
    cnum_array << row[1] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :number, cnum_array[count]
    count += 1
  end 

  cnum_array = [] # for instructors
  sheet1.each 2 do |row|
    cnum_array << row[2] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :instructor, cnum_array[count]
    count += 1
  end

  cnum_array = [] # for day
  sheet1.each 2 do |row|
    cnum_array << row[3] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :day, cnum_array[count]
    count += 1
  end

  cnum_array = [] # for time
  sheet1.each 2 do |row|
    cnum_array << row[4] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :time, cnum_array[count]
    count += 1
  end


  cnum_array = [] # for room
  sheet1.each 2 do |row|
    cnum_array << row[5] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :room, cnum_array[count]
    count += 1
  end


  cnum_array = [] # for units
  sheet1.each 2 do |row|
    cnum_array << row[6] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :units, cnum_array[count]
    count += 1
  end

  cnum_array = [] # for limitations
  sheet1.each 2 do |row|
    cnum_array << row[7] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :limitations, cnum_array[count]
    count += 1
  end


  cnum_array = [] # for http addresses
  sheet1.each 2 do |row|
    cnum_array << row[8] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :address, cnum_array[count]
    count += 1
  end
'''
  cnum_array = [] # for start times
  sheet1.each 2 do |row|
    unless row[9].blank?
      time = Time.parse(row[9])
      time = time.utc
      time = time.to_s
      time = time.delete "-"
      time = time.delete ":"
      time = time.delete "UTC"
      time = time.chop
      time = time.gsub(" ", "T")
      time = time.insert -1, "Z"
      cnum_array << time
    end 
  end

  count = 0
  for course in Course.all
    course.update_attribute :start_time, cnum_array[count]
    count += 1
  end
  
  cnum_array = [] # for end times
  sheet1.each 2 do |row|
    unless row[9].blank?
      time = Time.parse(row[10])
      time = time.utc
      time = time.to_s
      time = time.delete "-"
      time = time.delete ":"
      time = time.delete "UTC"
      time = time.chop
      time = time.gsub(" ", "T")
      time = time.insert -1, "Z"
      cnum_array << time
    end 
  end

  count = 0
  for course in Course.all
    course.update_attribute :end_time, cnum_array[count]
    count += 1
  end

end 
