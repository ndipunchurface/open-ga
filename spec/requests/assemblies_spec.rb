require 'spec_helper'

describe "Assemblies" do
  let(:user) { Factory(:user) }
  let(:assembly) { Factory(:assembly) }

  def sign_in
    @assembly = Assembly.create(Factory.attributes_for(:assembly))
    @user = User.new(Factory.attributes_for(:user))
    @user.assembly = @assembly
    @user.save!
    puts @user.inspect
    visit new_user_session_path
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_link_or_button "Sign in"
  end

  describe "GET /assemblies" do
    it "redirects if not signed in" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get assemblies_path
      response.status.should be(302)
    end
  end

  describe "GET /assembly/:id" do

    before(:each) do
      sign_in
    end

    it "should use uuid to find assembly" do
      get assembly_path(@assembly.uuid)
      response.status.should be(200)
    end

    it "should not use id to find assembly" do
      get assembly_path(@assembly.id)
      response.status.should be(302)
    end
  end
end
