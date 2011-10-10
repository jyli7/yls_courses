desc "Get evaluation link for each class"
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
  