require 'spec_helper'

describe "Assemblies" do
  let(:user) { Factory.create(:user) }
  let(:assembly) { Factory.create(:assembly) }

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
end
