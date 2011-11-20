FactoryGirl.define do
  factory :user do |user|
    user.email "foo@yale.edu"
    user.password "password"
    user.password_confirmation "password"
    user.after_build do |u|
      u.confirm!
      u.save!
     end
  end 
end