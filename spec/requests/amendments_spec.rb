require 'spec_helper'

describe "Amendments" do
  let(:owner) { Factory.create(:user) }
  let(:user) { Factory.create(:user) }
  let(:assembly) { Factory.create(:assembly, :user => owner) }
  let(:proposal) { assembly.proposals.create(Factory.attributes_for(:proposal, :user => user)) }

  def sign_in
    user.authorize(assembly)
    page.driver.post user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
  end

  before(:each) do
    sign_in
  end

  describe "GET /amendments" do
    it "shows all amendments" do
      #Amendment.create(Factory.attributes_for(:amendment, :user => user, :proposal => proposal))
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit assembly_proposal_amendments_path(assembly,proposal)
      page.should have_content("Amendments")
    end
  end

  describe "PUT /amendment" do
    it "creates amendment when valid parameters" do
      visit new_assembly_proposal_amendment_path(assembly,proposal)
      amendment_attr = proposal.amendments.build(Factory.attributes_for(:amendment))
      fill_in 'amendment_title', :with => amendment_attr[:title]
      fill_in 'amendment_body', :with => amendment_attr[:body]
      click_button 'submit'
      page.should have_content("Amendment was submitted successfully")
    end

    it "fails when no content for amendment is submitted" do
      visit new_assembly_proposal_amendment_path(assembly,proposal)
      click_button 'submit'
      page.should have_content("New")
      page.html.should match(/error/)
    end

    it "fails when short body for amendment is submitted" do
      visit new_assembly_proposal_amendment_path(assembly,proposal)
      amendment_attr = Factory.attributes_for(:amendment)
      fill_in 'amendment_title', :with => amendment_attr[:title]
      fill_in 'amendment_body', :with => 'less than 140 chars'
      click_button 'submit'
      page.should have_content("New")
      page.html.should match(/error/)
    end

    it "fails when short title for amendment is submitted" do
      visit new_assembly_proposal_amendment_path(assembly,proposal)
      amendment_attr = Factory.attributes_for(:amendment)
      title = "longer than 140 chars"
      140.times { title += "x" }
      fill_in 'amendment_title', :with => title
      fill_in 'amendment_title', :with => amendment_attr[:title]
      click_button 'submit'
      page.should have_content("New")
      page.html.should match(/error/)
    end
  end

  describe "PUT /amendment/:id" do
    let(:amendment) { Factory(:amendment, :proposal => proposal, :user => user) }

    it "fails when amendment is not owned by curent user" do
      other_amendment = Factory.create(:amendment, :proposal => proposal, :user => owner)
      visit edit_assembly_proposal_amendment_path(assembly,proposal,other_amendment)
      page.should have_content("You are not authorized")
    end

    it "updates amendment when valid parameters" do
      visit edit_assembly_proposal_amendment_path(assembly,proposal,amendment)
      body = "valid body"
      140.times {body += "x"}
      fill_in 'amendment_body', :with => body
      click_button 'submit'
      current_path.should == assembly_proposal_amendment_path(assembly,proposal,amendment)
      page.should have_content("Amendment was updated successfully")
    end

    it "fails when no content for amendment is submitted" do
      visit edit_assembly_proposal_amendment_path(assembly,proposal,amendment)
      fill_in 'amendment_title', :with => ''
      fill_in 'amendment_body', :with => ''
      click_button 'submit'
      page.should have_content("New")
      page.html.should match(/error/)
    end

    it "fails when short body for amendment is submitted" do
      visit edit_assembly_proposal_amendment_path(assembly,proposal,amendment)
      fill_in 'amendment_body', :with => 'less than 140 chars'
      click_button 'submit'
      page.should have_content("New")
      page.html.should match(/error/)
    end

    it "fails when long title for amendment is submitted" do
      visit edit_assembly_proposal_amendment_path(assembly,proposal,amendment)
      title = "longer than 140 chars"
      140.times { title += "x" }
      fill_in 'amendment_title', :with => title
      click_button 'submit'
      page.should have_content("New")
      page.html.should match(/error/)
    end
  end

  describe "DELETE /amendment/:id" do
    let(:amendment) { Factory.create(:amendment, :proposal => propsal, :user => user) }

    #it "fails when amendment is not owned by curent user" do
    #  other_amendment = Factory.create(:amendment, :proposal => proposal, :user => owner)
    #  delete assembly_proposal_amendment_path(assembly,proposal,other_amendment)
    #  response.should redirect_to(assembly_proposal_amendments_path(assembly,proposal))
    #end
  end
end
