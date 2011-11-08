require File.dirname(__FILE__) + '/../spec_helper'

describe Proposal, :type => :model do
  it "should order by popularity" do
    p0 = Proposal.create(:user_id => 1, :title => "dont mind me", :body => "blah") #jsut to make sure the one I'm looking for doesn't come back first
    p1 = Proposal.create(:user_id => 0, :title => "test1", :body=>"testbody")
    p2 = Proposal.create(:user_id => 0, :title => "test2", :body=>"testbody")

    p1.votes.create(:user_id => 0)
    p1.votes.create(:user_id => 1)

    p2.votes.create(:user_id => 1)

    p3 = Proposal.most_popular.first
    p3.title.should == p1.title
  end
end
