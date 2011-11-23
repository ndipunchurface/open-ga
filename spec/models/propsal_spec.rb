require 'spec_helper'

describe Proposal, :type => :model do
  it "should order by popularity" do
    p0 = Factory(:proposal)    
    p1 = Factory(:proposal)
    p2 = Factory(:proposal)

    2.times do |i|
      p1.upvote(i)
    end

    3.times do |i|
      p2.upvote(i)
    end

    2.times do |i|
      p2.downvote(i+3)
    end
    puts Proposal.most_popular.to_sql
    p3 = Proposal.most_popular.first
    p3.title.should == p1.title
  end

  it "should upvote" do
    proposal= Factory(:proposal) 
    proposal.votes.length.should == 0

    proposal.upvote(3)

    proposal.votes.length.should == 1
  end

  it "should downvote" do
    proposal = Factory(:proposal) 
    proposal.upvote(3)

    proposal.downvote(4)
    proposal.votes.length.should == 2
  end

  it "should have net_vote of 1" do
    proposal = Factory(:proposal)
    proposal.upvote(3)
    proposal.upvote(4)

    proposal.downvote(5)
    
    proposal.net_votes.should == 1
  end
    
  it "should find porposals with binding votes" do
    proposal = Factory(:proposal)
    proposal.binding_votes.create
    other_proposal = Factory(:proposal) 

    p_with_bvote = Proposal.binding
    p_with_bvote.length.should == 1

    p_with_bvote.first.title.should == proposal.title
  end
end
