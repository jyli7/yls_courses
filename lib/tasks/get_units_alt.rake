desc "Get evaluation link for each class"
task :get_units_alt => :environment do
    
  for course in Course.all
    if course.units == '1, 2, or 3'
      course.update_attribute :units_alt, '1-3'
      course.update_attribute :units, '1, 2, or 3'
    else 
      course.update_attribute :units_alt, course.units
    end 
  end 

end 