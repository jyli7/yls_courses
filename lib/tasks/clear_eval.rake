desc "Clear evals for each course"
task :clear_evals => :environment do 
  
  for course in Course.all 
    unless course.crn.nil?
      course.update_attribute :crn, nil
    end 
    unless course.term_code.nil?
      course.update_attribute :term_code, nil
    end
    unless course.past_instructors.nil?
      course.update_attribute :past_instructors, nil
    end
    unless course.past_semesters.nil?
      course.update_attribute :past_semesters, nil
    end
  end 
end 
     