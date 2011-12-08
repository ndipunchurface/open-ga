require 'spec_helper'

describe "Proposals" do

  let(:user) { Factory.create(:user) }
  let(:assembly) { Factory.create(:assembly) }

  def sign_in
    user.authorize(assembly)
    page.driver.post user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
  end

  before(:each) do
    sign_in
    @proposal = assembly.proposals.create(Factory.attributes_for(:proposal, :user => user))
  end

  describe "PUT /proposals" do
    it "creates proposal when valid parameters" do
      visit new_assembly_proposal_path(assembly)
      proposal_attr = Factory.attributes_for(:proposal)
      fill_in 'proposal_title', :with => proposal_attr[:title]
      fill_in 'proposal_body', :with => proposal_attr[:body]
      click_button 'submit'
      current_path.should == assembly_proposal_path(assembly, Proposal.last)
      page.should have_content("Proposal submitted successfully")
    end

    it "fails when invalid proposal is submitted" do
      visit new_assembly_proposal_path(assembly)
      click_button 'submit'
      page.should have_content("New")
      page.html.should match(/error/)
    end
  end

  describe "PUT /proposals/:id" do

    it "redirects if proposal not owned by current user" do
      proposal = assembly.proposals.create(Factory.attributes_for(:proposal, :user => Factory.create(:user)))
      visit edit_assembly_proposal_path(assembly.uuid, proposal.id)
      page.should have_content("You are not authorized")
    end

    it "updates proposal when valid parameters" do
      visit edit_assembly_proposal_path(assembly.uuid,@proposal.id)
      fill_in 'proposal_title', :with => "A different title"
      click_button 'submit'
      current_path.should == assembly_proposal_path(assembly.uuid,@proposal.id)
      page.should have_content("Proposal updated successfully")
    end

    it "fails when invalid changes are submitted" do
      visit edit_assembly_proposal_path(assembly.uuid,@proposal.id)
      fill_in 'proposal_title', :with => 'la' #too short
      click_button 'submit'
      page.html.should match(/error/)
    end
  end
end
