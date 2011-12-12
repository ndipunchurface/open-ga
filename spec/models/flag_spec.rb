require 'spec_helper'

describe Flag do
  let(:proposal) { Factory(:proposal) }
  let(:user) { Factory(:user) }

  it "should find by flaggable" do
    proposal.flag(user.id)
    Flag.find_by_flaggable(proposal).length.should == 1
  end
end
