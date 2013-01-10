require "spec_helper"

describe "/users routes" do
  it "should not have destroy route" do
    { :delete=> "/users" }.should_not be_routable
  end
end
