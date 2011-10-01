desc "Get evaluation link for each class"
task :get_evals => :environment do

  2011.downto(2004) do |count|
    file = File.new("course_data/Spring#{count}.html")
    text = file.readlines
    text = text.join('\n')

    for course in Course.all    
      eval = /\(([0-9]+), ([0-9]+)\)">#{course.name}/.match text
      puts "#{count}"
      if eval
        if course.evals.nil?
          course.update_attribute :evals, [eval[1]]
        else
          course.evals << eval[1]
        end
        course.evals << eval[2]
        course.evals << "Spring #{count}"  
        course.save
        puts "#{count}"
      end 
    end
  
    fall_count = count-1
  
    file = File.new("course_data/Fall#{fall_count}.html")
    text = file.readlines
    text = text.join('\n')
  
    for course in Course.all    
      eval = /\(([0-9]+), ([0-9]+)\)">#{course.name}/.match text
      if eval
        if course.evals.nil?
          course.update_attribute :evals, [eval[1]]
        else
          course.evals << eval[1]
        end
        course.evals << eval[2]
        course.evals << "Fall #{fall_count}"  
        course.save
      end
    end
  end

end 