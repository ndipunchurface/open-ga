require 'spec_helper'

describe "Amendments" do
  let(:user) { Factory(:user) }
  let(:assembly) { Factory(:assembly) }
  let(:proposal) { Factory(:proposal, :assembly => assembly) }

  describe "GET /amendments" do
    it "works! (now write some real specs)" do
      Amendment.create(Factory.attributes_for(:amendment, :user => user))
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get assembly_proposal_amendments_path(assembly,proposal)
      response.status.should be(200)
    end
  end
end
