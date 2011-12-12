require 'spec_helper'

describe "Tags" do
  let(:assembly) { Factory.create(:assembly) }
  let(:tag) { Factory.create(:tag) }
  let(:taxonomy) { assembly.taxonomies.build(:tag_id => tag.id) }
  let(:user) { Factory.create(:user) }

  def sign_in
    user.authorize(assembly)
    page.driver.post user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
  end

  describe "GET /tag" do
    before(:each) do
      proposals = Array.new
      3.times do
        proposals.push(Factory.create(:proposal))
        proposals.last.tag_with(tag.name)
      end
      sign_in
    end
        
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit assembly_tag_path(assembly.uuid,tag.name)
      page.html.should match(/\<title\>#/)
    end
  end
end
