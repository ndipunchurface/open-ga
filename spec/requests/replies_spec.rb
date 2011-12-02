require 'spec_helper'

describe "Replies" do
  let(:user) { Factory(:user) }
  let(:assembly) { Factory(:assembly) }
  let(:proposal) { Factory(:proposal, :assembly => assembly) }
  let(:amendment) { Factory(:amendment, :proposal => proposal) }

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

  before(:each) do
    sign_in
  end

  describe "PUT proposal/replies" do
    it "creates reply when valid parameters" do
      visit new_assembly_proposal_reply_path(@assembly,proposal)
      reply_attr = Factory.attributes_for(:reply)
      fill_in 'reply_body', :with => reply_attr[:body]
      click_button 'submit'
      current_path.should == assembly_proposal_path(@assembly,proposal)
      page.should have_content("Reply submitted successfully")
    end

    it "fails when invalid reply is submitted" do
      visit new_assembly_proposal_reply_path(@assembly,proposal)
      click_button 'submit'
      page.should have_content("Reply")
      page.html.should match(/error/)
    end
  end

  describe "PUT amendment/replies" do
    it "creates reply when valid parameters" do
      visit new_assembly_proposal_amendment_reply_path(@assembly,proposal,amendment)
      reply_attr = Factory.attributes_for(:reply)
      fill_in 'reply_body', :with => reply_attr[:body]
      click_button 'submit'
      current_path.should == assembly_proposal_amendment_path(@assembly,proposal,amendment)
      page.should have_content("Reply submitted successfully")
    end

    it "fails when invalid reply is submitted" do
      visit new_assembly_proposal_amendment_reply_path(@assembly,proposal,amendment)
      click_button 'submit'
      page.should have_content("Reply")
      page.html.should match(/error/)
    end
  end
end
