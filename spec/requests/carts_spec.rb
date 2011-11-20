require 'spec_helper'

describe "Carts" do
  describe "GET /carts", :js => true do
    it "works! (now write some real specs)" do
      user = FactoryGirl.build(:user, :password => "password123", :password_confirmation => "password123")
      user.confirm!
      user.save!
      user = User.find_by_email(user.email)
      user.password.should be_blank
      visit courses_path
      click_link "Sign in"
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => "password123"
      click_button "user_submit"
      page.should have_content(user.email)
      get carts_path
      response.status.should be(200)

    end
  end
end
