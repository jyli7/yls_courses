require 'spec_helper'

describe User do
  it "should have a factory" do
    user = FactoryGirl.create(:user)
    user.should be_valid
    user.should be_confirmed
  end
end
