desc "Clear evals for each course"
task :clear_evals => :environment do 
  
  for course in Course.all 
    unless course.evals.nil?
      course.update_attribute :evals, nil
    end 
  end 
end 
     