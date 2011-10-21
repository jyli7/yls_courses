desc "Destroy all users"
task :destroy_all_users=> :environment do 
  
  for user in User.all 
    user.destroy
  end 
end