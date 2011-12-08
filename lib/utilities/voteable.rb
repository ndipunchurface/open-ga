module Voteable
  def self.included(base)
    base.class_eval do
      has_many :votes, :as => :voteable
      after_create do
        upvote(user_id)
      end
    end
  end

  def upvote(userid)
    votes.create({:user_id => userid,:upvote => 1}) unless user_has_voted?(userid)
  end

  def downvote(userid)
    votes.create({:user_id => userid,:upvote => -1}) unless user_has_voted?(userid)
  end

  def user_has_voted?(userid)
    votes.exists?(:user_id => userid)
  end

  def upvotes
    votes.find(:all,:conditions => {:upvote => 1})
  end

  def num_upvotes
    upvotes.length
  end

  def downvotes
    votes.find(:all,:conditions => {:upvote => -1})
  end

  def num_downvotes
    downvotes.length
  end

  def net_votes
    num_upvotes - num_downvotes
  end

end
