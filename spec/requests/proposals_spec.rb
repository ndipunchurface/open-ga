require 'spec_helper'

describe "Proposals" do

  def sign_in
    @assembly = Assembly.create(Factory.attributes_for(:assembly))
    @user = User.new(Factory.attributes_for(:user))
    @user.assembly = @assembly
    @user.save!
    visit new_user_session_path
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_link_or_button "Sign in"
  end

  before(:each) do
    sign_in
  end

  let(:user) { Factory(:user) }
  let(:assembly) { Factory(:assembly) }

  describe "PUT /proposals" do
    it "creates proposal when valid parameters" do
      visit new_assembly_proposal_path(@assembly)
      proposal_attr = Factory.attributes_for(:proposal)
      fill_in 'proposal_title', :with => proposal_attr[:title]
      fill_in 'proposal_body', :with => proposal_attr[:body]
      click_button 'submit'
      current_path.should == assembly_proposal_path(@assembly, Proposal.last)
      page.should have_content("Proposal submitted successfully")
    end

    it "fails when invalid proposal is submitted" do
      visit new_assembly_proposal_path(@assembly)
      click_button 'submit'
      page.should have_content("New")
      page.html.should match(/error/)
    end
  end

  describe "PUT /proposals/:id" do
    it "updates proposal when valid parameters" do
      proposal = Factory(:proposal, :assembly_id => @assembly.uuid, :user => @user)
      visit edit_assembly_proposal_path(@assembly,proposal)
      fill_in 'proposal_title', :with => "A different title"
      click_button 'submit'
      current_path.should == assembly_proposal_path(@assembly,proposal)
      page.should have_content("Proposal updated successfully")
    end

    it "fails when invalid changes are submitted" do
      proposal = Factory(:proposal, :assembliy_id => @assembly.uuid, :user => @user)
      visit edit_assembly_proposal_path(@assembly,proposal)
      fill_in 'proposal_title', :with => 'la' #too short
      click_button 'submit'
      page.html.should match(/error/)
    end
  end
end
