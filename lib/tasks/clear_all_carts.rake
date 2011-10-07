desc "Destroy all carts"
task :destroy_all_carts => :environment do 
  
  for cart in Cart.all 
    cart.destroy
  end 
end 
     