require 'spec_helper'

describe Flag do
  let(:proposal) { Factory(:proposal) }

  it "should find by flaggable" do
    proposal.flag
    Flag.find_by_flaggable(proposal).length.should == 1
  end
end
