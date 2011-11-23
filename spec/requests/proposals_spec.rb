require 'spec_helper'

describe "Proposals" do
  let(:user) { Factory(:user) }

  describe "PUT /proposals" do
    it "creates proposal when valid parameters" do
      visit new_proposal_path
      proposal_attr = Factory.attributes_for(:proposal)
      fill_in 'proposal_title', :with => proposal_attr[:title]
      fill_in 'proposal_body', :with => proposal_attr[:body]
      click_button 'submit'
      current_path.should == proposal_path(Proposal.last)
      page.should have_content("Proposal submitted successfully")
    end

    it "fails when invalid proposal is submitted" do
      visit new_proposal_path
      click_button 'submit'
      page.should have_content("New")
      page.html.should match(/error/)
    end
  end

  describe "PUT /proposals/:id" do
    it "updates proposal when valid parameters" do
      proposal = Factory(:proposal)
      visit edit_proposal_path(proposal)
      fill_in 'proposal_title', :with => "A different title"
      click_button 'submit'
      current_path.should == proposal_path(proposal)
      page.should have_content("Proposal updated successfully")
    end

    it "fails when invalid changes are submitted" do
      proposal = Factory(:proposal)
      visit edit_proposal_path(proposal)
      fill_in 'proposal_title', :with => 'la' #too short
      click_button 'submit'
      page.html.should match(/error/)
    end
  end
end
