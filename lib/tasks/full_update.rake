desc "Destroy all classes to prepare for update"
task :destroy_all_classes => :environment do 
  LineItem.all.each do |l|
    l.destroy
  end
  
  Course.all.each do |c| 
    c.destroy
  end 
end

desc "Shortens limitations descriptions"
task :limitations_shorten => :environment do
  Course.all.each do |c|
    if c.limitations == "Permission of Instructor"
      c.update_attribute :limitations, "Permission"
    elsif c.limitations == "LSO Ballot Required"
      c.update_attribute :limitations, "LSO"
    end 
  end
end

desc "Fetch law classes"
task :fetch_classes => :environment do 
  require 'spreadsheet'
  require 'rubygems'
  require 'time'

  Spreadsheet.client_encoding = 'UTF-8'

  book = Spreadsheet.open '/Users/jimmyli/rails_projects/yls_courses/public/data/YLS_Classes.xls'
  sheet1 = book.worksheet 'Sheet1'

  temp_array = [] # for names
  sheet1.each 2 do |row|
    temp_array << row[0] 
  end
    
  for name in temp_array
    Course.create!(:name => name) 
  end
  
  temp_array = [] # for course numbers
  sheet1.each 2 do |row|
    temp_array << row[1] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :number, temp_array[count]
    count += 1
  end

  temp_array = [] # for instructors
  sheet1.each 2 do |row|
    temp_array << row[2] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :instructor, temp_array[count]
    count += 1
  end

  temp_array = [] # for day
  sheet1.each 2 do |row|
    temp_array << row[3] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :day, temp_array[count]
    count += 1
  end

  temp_array = [] # for time
  sheet1.each 2 do |row|
    temp_array << row[4] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :time, temp_array[count]
    count += 1
  end

  temp_array = [] # for room
  sheet1.each 2 do |row|
    temp_array << row[5] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :room, temp_array[count]
    count += 1
  end


  temp_array = [] # for units
  sheet1.each 2 do |row|
    temp_array << row[6] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :units, temp_array[count]
    count += 1
  end

  temp_array = [] # for limitations
  sheet1.each 2 do |row|
    temp_array << row[7] 
  end

  count = 0
  for course in Course.all
    course.update_attribute :limitations, temp_array[count]
    count += 1
  end
  
  Course.all.each do |c|
    if c.name.blank?
      c.destroy
    end
  end
end 

desc "Get http address for each class"
task :get_address => :environment do 
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  address_array = []
  doc = Nokogiri::HTML(open("http://ylsinfo.law.yale.edu/wsw/prereg/course_overview.asp?Term=Spring"))
  r = /href=\"(.*)\">/
  doc.css("div a").each do |link|
    link = link.to_s
    m = link.match r
    address = "http://ylsinfo.law.yale.edu/wsw/prereg/" + m[1]
    address_array << address #add each address to the address array
  end
  
  count = 0
  Course.all.each do |c|
    c.update_attribute :address, address_array[count]
    count += 1
  end 
  
  Course.all.each do |c| #destroy nil courses
    if c.name.blank?
      c.destroy
    end 
  end
end

desc "Get evaluation link for each class"
task :get_evals => :environment do

  2011.downto(2004) do |count|
    file = File.new("course_data/Spring#{count}.html")
    text = file.readlines
    text = text.join('\n')

    for course in Course.all
      #      eval = /\(([0-9]+), ([0-9]+)\)">#{course.name}<\/a>&nbsp;([^<]+)/m.match text    
      eval = /\(([0-9]+), ([0-9]+)\)">#{course.name[0..2]}.*#{course.name[-3..-1]}<\/a>&nbsp;([^<]+)/m.match text
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
      eval = /\(([0-9]+), ([0-9]+)\)">#{course.name[0..2]}.*#{course.name[-3..-1]}<\/a>&nbsp;([^<]+)/m.match text
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

desc "Get description of each class"
task :get_descrip => :environment do 
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  for course in Course.all
    url = course.address
    unless url.blank?
      doc = Nokogiri::HTML(open(url))
      new_descrip = doc.at_css("tr:nth-child(4) td").text
      course.update_attribute :descrip, new_descrip
    end 
  end 
end 

desc "Get test or paper options for each class"
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

desc "Get a time_num for each time, to be used for future sorting"
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
  
desc "Categorize each course's time into 'morning', 'early aft', 'late aft', 'evening'"
task :get_tod => :environment do

  for course in Course.all
    t = course.time

    if t.blank? #if course has no time at all, move to the next course
      course.update_attribute :tod, 'No set time'  
      next
    end 

    colon_location = t.index(':') #determine the number of digits before :
    print course.name, colon_location

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
    end 
  end
end

desc "Create a units_alt (e.g. 1-3) for display"
task :get_units_alt => :environment do

  for course in Course.all
    if course.units == '1-3'
      course.update_attribute :units_alt, '1-3'
      course.update_attribute :units, '1, 2, or 3'
    else 
      course.update_attribute :units_alt, course.units
    end 
  end 
end 

desc "Get a day_num, so that sort is based on days of week, not alphabet"
task :day_sort_fix => :environment do
  days = ['M', 'T', 'W', 'Th', 'F']
  
  def gen_comb_array(array)
    ca = [] #ca for "combination_array"
    first = array[0]
    ca << first #add first day to the array, e.g. "M"
    len = array.length
    new_array = array[1...len]
    for element in new_array
      ca << first + element #add combo of first day + all other day combos, e.g. "MT", "MW", "MTh", etc. 
    end 
    if new_array.length > 1
      ca << gen_comb_array(new_array)
    else 
      ca << new_array
      return ca
    end 
  end 
  
  p gen_comb_array(days).flatten
  
  days_comb = gen_comb_array(days).flatten
  
  for course in Course.all 
    day_num = days_comb.index(course.day)
    course.update_attribute :day_num, day_num 
  end 
end

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

desc "Get higher-level evaluations from unofficial spreadsheet"
task :get_other_evals => :environment do 
  
  require 'spreadsheet'
  require 'rubygems'
  require 'time'

  Spreadsheet.client_encoding = 'UTF-8'

  book = Spreadsheet.open '/Users/jimmyli/rails_projects/yls_courses/public/data/class_action_ratings_2.xls'
  sheet1 = book.worksheet 'Sheet1'

  #Store data from spreadsheet
  #If spreadsheet names match (some part) of existing names, then attach the additional information
  count = 0
  sheet1.each 1 do |row|
    spreadsheet_course_name_array = row[0].split()
    spreadsheet_prof_name_array = row[1].split(",")
    spreadsheet_instructor_quality = row[2]
    spreadsheet_classtime_value = row[3]
    spreadsheet_workload = row[4]
    count += 1
    Course.all.each do |course|
      #returns true if a 1 to 1 match between the professor list in the spreadsheet and the professor list in the database
      prof_match = false
      spreadsheet_prof_name_array.each do |prof|
        if course.instructor.include? prof
          prof_match = true 
          break
        end
      end
      if course.name.include? spreadsheet_course_name_array[0][1..3] and course.name.include? spreadsheet_course_name_array[-1][1..3] and prof_match
        course.update_attribute :instructor_quality, spreadsheet_instructor_quality.to_f.round(1)
        course.update_attribute :classtime_value, spreadsheet_classtime_value.to_f.round(1)
        course.update_attribute :workload, spreadsheet_workload.to_f.round(1)
      end 
    end 
    
  end
end 

task :full_update => [:destroy_all_classes, :fetch_classes, :get_address, :get_evals, :get_descrip, :get_testing, :get_time_num, :get_tod, :change_units, :get_units_alt, :day_sort_fix, :limitations_shorten, :get_other_evals] do
  puts "Full update complete!"
end 
