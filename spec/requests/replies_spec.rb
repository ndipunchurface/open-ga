require 'spec_helper'

describe "Replies" do
  let(:owner) { Factory.create(:user) }
  let(:user) { Factory.create(:user) }
  let(:assembly) { Factory.create(:assembly, :user => owner) }
  let(:proposal) { assembly.proposals.create(Factory.attributes_for(:proposal)) }
  let(:amendment) { Factory.create(:amendment, :proposal => proposal) }

  def sign_in
    user.authorize(assembly)
    page.driver.post user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
  end

  before(:each) do
    sign_in
  end

  describe "PUT proposal/replies" do
    it "creates reply when valid parameters" do
      visit new_assembly_proposal_reply_path(assembly,proposal)
      reply_attr = Factory.attributes_for(:reply)
      fill_in 'reply_body', :with => reply_attr[:body]
      click_button 'submit'
      current_path.should == assembly_proposal_path(assembly,proposal)
      page.should have_content("Reply submitted successfully")
    end

    it "fails when invalid reply is submitted" do
      visit new_assembly_proposal_reply_path(assembly,proposal)
      click_button 'submit'
      page.should have_content("Reply")
      page.html.should match(/error/)
    end
  end

  describe "PUT amendment/replies" do
    it "creates reply when valid parameters" do
      visit new_assembly_proposal_amendment_reply_path(assembly,proposal,amendment)
      reply_attr = Factory.attributes_for(:reply)
      fill_in 'reply_body', :with => reply_attr[:body]
      click_button 'submit'
      current_path.should == assembly_proposal_amendment_path(assembly,proposal,amendment)
      page.should have_content("Reply submitted successfully")
    end

    it "fails when invalid reply is submitted" do
      visit new_assembly_proposal_amendment_reply_path(assembly,proposal,amendment)
      click_button 'submit'
      page.should have_content("Reply")
      page.html.should match(/error/)
    end
  end
end
