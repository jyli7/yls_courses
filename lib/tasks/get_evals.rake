desc "Get evaluation link for each class"
task :get_evals => :environment do

  2011.downto(2008) do |count|
    file = File.new("course_data/Spring#{count}.html")
    text = file.readlines
    text = text.join('\n')
    
    for course in Course.all    
      eval = /\(([0-9]+), ([0-9]+)\)">#{course.name}<\/a>&nbsp;([^<]+)/m.match text
      if eval
        eval_a = [eval[1], eval[2], eval[3]]
        
        if course.crn.blank?
          course.update_attribute :crn, [eval_a[0]]
        else
          course.crn << eval_a[0]
        end
        
        if course.term_code.blank?
          course.update_attribute :term_code, [eval_a[1]]
        else
          course.term_code << eval_a[1]
        end
            
        if eval_a[2]
          eval_a[2].strip!.sub!(/\\n\s*/, '').gsub!(/,&nbsp;\s*\\n\s*/, ', ')
        end   

        if course.past_instructors.blank?
          course.update_attribute :past_instructors, [eval_a[2]]
        else
          course.past_instructors << eval_a[2]
        end

        if course.past_semesters.blank?
          course.update_attribute :past_semesters, ["Spring #{count}"]
        else
          course.past_semesters << "Spring #{count}"
        end

        course.save
      end 
    end
  
    fall_count = count-1
  
    file = File.new("course_data/Fall#{fall_count}.html")
    text = file.readlines
    text = text.join('\n')
  
    for course in Course.all    
      eval = /\(([0-9]+), ([0-9]+)\)">#{course.name}<\/a>&nbsp;([^<]+)/m.match text
      if eval
        eval_a = [eval[1], eval[2], eval[3]]

        if course.crn.blank?
          course.update_attribute :crn, [eval_a[0]]
        else
          course.crn << eval_a[0]
        end
        
        if course.term_code.blank?
          course.update_attribute :term_code, [eval_a[1]]
        else
          course.term_code << eval_a[1]
        end
  
        if eval_a[2]
          eval_a[2].strip!.sub!(/\\n\s*/, '').gsub!(/,&nbsp;\s*\\n\s*/, ', ') #clean up past_instructors string        
        end         

        if course.past_instructors.blank?
          course.update_attribute :past_instructors, [eval_a[2]]
        else
          course.past_instructors << eval_a[2]
        end

        if course.past_semesters.blank?
          course.update_attribute :past_semesters, ["Fall #{fall_count}"]
        else
          course.past_semesters << "Fall #{fall_count}"
        end

        course.save
      end 
    end 
  end 
end 