require 'spec_helper'

describe "Users" do
  let(:owner) { Factory.create(:user) }
  let(:assembly) { Factory.create(:assembly, :user => owner) }
  let(:user) { Factory.create(:user) }
  
  def sign_in
    user.authorize(assembly)
    page.driver.post user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
  end

  before(:each) do
    sign_in
  end

  describe "GET /users" do
    it "should redirect non-admin user with error message" do
      visit assembly_users_path(assembly)
      page.should have_content("You are not authorized to perform this action")
    end

    it "should allow admin to view page" do
      user.make_facilitator(assembly)
      user.is_admin?(assembly).should == true
      visit assembly_users_path(assembly)
      page.should have_content("Authorized users for")
    end
  end
end
