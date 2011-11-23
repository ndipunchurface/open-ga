require 'spec_helper'

describe User do
  let(:user) { Factory(:user) }

  it "returns false for is_admin? when user is not admin" do
    user.is_admin?.should == false
  end

  it "returns true for is_admin when user is an admin" do
    admin = Factory(:admin_user)
    admin.is_admin?.should == true
  end
end
