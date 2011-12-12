require 'spec_helper'

describe Proposal, :type => :model do
  let(:user) { Factory(:user) }

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
    p3 = Proposal.most_popular.first
    p3.title.should == p1.title
  end

  it "should order by popularity with limit" do
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

    p = Proposal.most_popular(3)
    p.length.should == 3
  end

  describe "Voting" do
    it "should upvote" do
      proposal= Factory(:proposal) 
      proposal.votes.length.should == 1

      proposal.upvote(user)

      proposal.votes.length.should == 2
    end

    it "should downvote" do
      proposal = Factory(:proposal) 
      proposal.upvote(3)

      proposal.downvote(4)
      proposal.votes.length.should == 3
    end

    it "should have net_vote of 1" do
      proposal = Factory(:proposal)
      proposal.upvote(3)
      proposal.upvote(4)

      proposal.downvote(5)
      
      proposal.net_votes.should == 2
    end
      
    it "should find porposals with binding votes" do
      proposal = Factory(:proposal)
      proposal.binding_votes.create
      other_proposal = Factory(:proposal) 

      p_with_bvote = Proposal.binding
      p_with_bvote.length.should == 1

      p_with_bvote.first.title.should == proposal.title
    end

    it "can be flagged" do
      proposal = Factory(:proposal)
      proposal.flag(user.id)
      Flag.find_by_flaggable(proposal).length.should == 1
    end

    it "cannot be flagged twice by same user" do
      proposal = Factory(:proposal)
      proposal.flag(user.id)
      proposal.flag(user.id)
      Flag.find_by_flaggable(proposal).length.should == 1
    end

    it "can be blocked" do
      proposal = Factory(:proposal)
      proposal.block(user.id)
      proposal.blocks.length.should == 1
    end

    it "cannot be block twice by same user" do
      proposal = Factory(:proposal)
      proposal.block(user.id)
      proposal.block(user.id)
      proposal.blocks.length.should == 1
    end
  end
  
  describe "Tagging" do
    it "should return tags for hashtagged proposal" do
      proposal = Factory.build(:proposal)
      proposal.body += " #hashtag"
      proposal.save!
      proposal.tag_names.include?("hashtag").should === true
    end

    it "should remove taxonomy of unused tags" do
      proposal = Factory.build(:proposal)
      body = proposal.body
      proposal.body += " #hashtag #tag"
      proposal.save!
      proposal.body = body + " #tag"
      proposal.save!
      proposal.tag_names.include?("hashtag").should == false
    end
  end
end
