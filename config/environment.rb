# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
YlsCourses::Application.initialize!

config.action_mailer.default_url_options = { :host => 'localhost:3000' }  

# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.smtp_settings = {
#    :tls => true,
#    :address => "smtp.gmail.com",
#    :port => 587,
#    :domain => "gmail.com",
#    :authentication => :login,
#    :user_name => APP_CONFIG['email'],
#    :password => APP_CONFIG['password']
#  }
