require 'spec_helper'

describe "Assemblies" do
  let(:owner) { Factory.create(:user) }
  let(:user) { Factory.create(:user) }
  let(:assembly) { Factory.create(:assembly, :user => owner) }

  def sign_in
    user.authorize(assembly)
    page.driver.post user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
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

    it "should show an assembly that user is attending" do
      visit assemblies_path
      page.should have_content(assembly.name)
    end

    it "should use uuid to find assembly" do
      visit assembly_path(assembly.uuid)
      page.should have_content('Proposals')
    end
  end

  describe "PUT /assembly" do

    before(:each) do
      sign_in
      @category = Factory.create(:category)
    end

    it "should make a new assembly with valid parameters" do
      visit new_assembly_path
      fill_in 'assembly_name', :with => "My random assembly"
      select @category.name, :from => 'assembly_category_id'
      click_button 'submit'
      page.should have_content("created!")
    end
  end
end
