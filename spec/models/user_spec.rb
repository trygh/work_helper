require "spec_helper"

describe User do

  it "should create dev_profile" do
    user = create :user
    user.dev_profile.should be
  end
end
