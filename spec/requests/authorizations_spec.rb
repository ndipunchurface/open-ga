require 'spec_helper'

describe "Authorizations" do
  let(:user) { Factory.create(:user) }
  let(:assembly) { Factory.create(:assembly) }

  def sign_in
    page.driver.post user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
  end

  before(:each) do
    sign_in
  end

  describe "PUT /authorization" do
    it "reroutes to authorizations#new when trying to access unauthorized assembly" do
      visit assembly_path(assembly)
      page.should have_content("You must be registered")
    end

    it "authorizes user with valid registration number" do
      registration = assembly.registration_numbers.create
      visit new_assembly_authorization_path(assembly)
      fill_in "registration_number", :with => registration.uuid
      click_button "submit"
      page.should have_content("You've successfully registered")
    end

    it "authorizes user with valid registration number case insensitive" do
      registration = assembly.registration_numbers.create
      visit new_assembly_authorization_path(assembly)
      fill_in "registration_number", :with => registration.uuid.upcase
      click_button "submit"
      page.should have_content("You've successfully registered")
    end

    it "fails when user enters invalid registration number" do
      visit new_assembly_authorization_path(assembly)
      fill_in "registration_number", :with => "550e8400-e29b-41d4-a716-446655440000"
      click_button "submit"
      page.should have_content("The registration number you've entered is invalid")
    end
  end
end
