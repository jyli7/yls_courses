desc "Get evaluation link for each class"
task :get_testing => :environment do

    for course in Course.all  
      
      course.update_attribute :exam_type, "None"
       
      if course.descrip =~ /examination/i
        course.update_attribute :exam_type, "Scheduled" 
      end
       
      if course.descrip =~ /no examination/i
        course.update_attribute :exam_type, "None" 
      end
      
      if course.descrip =~ /self-scheduled/i
        course.update_attribute :exam_type, "Self-scheduled" 
      end
      
      course.update_attribute :paper_type, "None"
      
      if course.descrip =~ /paper option/i 
        course.update_attribute :paper_type, "Option"
      end 

      if course.descrip =~ /paper required/i 
        course.update_attribute :paper_type, "Required"
      end 
    end          
      
end 