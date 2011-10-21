desc "Get description of each class"
task :change_units => :environment do 
  require 'rubygems'
  
  courses = Course.find_all_by_units("4.0")
  
  for course in courses 
    course.update_attribute :units, 4
  end
  
  courses = Course.find_all_by_units("2.0")
  
  for course in courses 
    course.update_attribute :units, 2
  end
  
  courses = Course.find_all_by_units("1.0")
  
  for course in courses 
    course.update_attribute :units, 1
  end
  
  courses = Course.find_all_by_units("3.0")
  
  for course in courses 
    course.update_attribute :units, 3
  end
  
end 
