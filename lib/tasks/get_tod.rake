desc "Categorize each course's time into 'morning', 'early aft', 'late aft', 'evening'"
task :get_tod => :environment do
    
  for course in Course.all
    t = course.time

    if t.nil? #if course has no time at all, move to the next course
      course.update_attribute :tod, 'No set time'  
    end 
"""    
    colon_location = t.index(':') #determine the number of digits before :

    if colon_location == 1 #if course time has only 1 digit before the colon, e.g. (1:00)
      i = t[0].to_i
      puts course.name
      if i >= 8 and i < 10
        course.update_attribute :tod, 'Morning (before 12)'
      elsif i >= 1 and i < 4
        course.update_attribute :tod, 'Early aft (12-4)'
      elsif i >= 4 and i < 6
        course.update_attribute :tod, 'Late aft (4-6)'
      elsif i >= 6
        course.update_attribute :tod, 'Evening (after 6)'
      end 

    elsif colon_location == 2 #if course time has 2 digits before the colon, e.g. (11:00 or 12:00)
      i = t[0..1].to_i
      if i < 12
        course.update_attribute :tod, 'Morning (before 12)'
      else
        course.update_attribute :tod, 'Early aft (12-4)'
      end 
"""      
  end 
end 