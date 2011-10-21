desc "Create a units_alt (e.g. 1-3) for display"
task :get_units_alt => :environment do
    
#"Units_alt" are the units that are displayed. "Units" are the ones that are searched for. 

  for course in Course.all
    if course.units == '1, 2, or 3'
      course.update_attribute :units_alt, '1-3'
    else 
      course.update_attribute :units_alt, course.units
    end 
  end 

end 