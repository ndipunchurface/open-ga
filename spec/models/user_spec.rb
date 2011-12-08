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

  it "can authorize user" do
    assembly = Factory.create(:assembly)
    user.authorize(assembly)
    user.authorized?(assembly).should === true
  end

  it "can unauthorize user" do
    assembly = Factory.create(:assembly)
    user.authorize(assembly)
    user.unauthorize(assembly)
    user.authorized?(assembly).should === false
  end
end
