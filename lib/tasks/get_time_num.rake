desc "Get evaluation link for each class"
task :get_time_num => :environment do
    
  for course in Course.all
    t = course.time

    if t.nil? #if course has no time at all, move to the next course
      course.update_attribute :time_num, nil  
      next
    end
    
    time_array = [8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6] 

    colon_location = t.index(':') #determine the number of digits before :

    if colon_location == 1 #if course time has only 1 digit before the colon, e.g. (1:00)
      i = t[0].to_i
    elsif colon_location == 2 #if course time has 2 digits before the colon, e.g. (11:00 or 12:00)
      i = t[0..1].to_i
    end 
    time_num = time_array.index(i)
    course.update_attribute :time_num, time_num      
  end 
end 