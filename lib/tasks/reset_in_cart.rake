desc "Get evaluation link for each class"
task :reset_in_cart => :environment do

  for course in Course.all
    if course.in_cart == true 
      course.update_attribute :in_cart, false 
    end 
  end 
end 