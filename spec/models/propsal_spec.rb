require File.dirname(__FILE__) + '/../spec_helper'

describe Proposal, :type => :model do
  it "should order by popularity" do
    p0 = Proposal.create(:user_id => 1, :title => "dont mind me", :body => "blah") #jsut to make sure the one I'm looking for doesn't come back first
    p1 = Proposal.create(:user_id => 0, :title => "test1", :body=>"testbody")
    p2 = Proposal.create(:user_id => 0, :title => "test2", :body=>"testbody")

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
    proposal= Proposal.create(:user_id => 1, :title => "aidsh", :body => "boiahds")
    proposal.votes.length.should == 0

    proposal.upvote(3)

    proposal.votes.length.should == 1
  end

  it "should downvote" do
    proposal = Proposal.create(:user_id => 1, :title => "aoisdhf", :body => "aosidhf")
    proposal.upvote(3)

    proposal.downvote(4)
    proposal.votes.length.should == 2
  end

  it "should have net_vote of 1" do
    proposal = Proposal.create(:user_id => 1, :title => "aosidhf", :body => "aoisdhfa")
    proposal.upvote(3)
    proposal.upvote(4)

    proposal.downvote(5)
    
    proposal.net_votes.should == 1
  end
    
    
end
