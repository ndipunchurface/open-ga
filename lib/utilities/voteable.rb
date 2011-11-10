module Voteable

  def upvote(userid)
    votes.create({:user_id => userid,:upvote => true}) unless user_has_voted?(userid)
  end

  def downvote(userid)
    votes.create({:user_id => userid,:upvote => false}) unless user_has_voted?(userid)
  end

  def user_has_voted?(userid)
    votes.exists?(:user_id => userid)
  end

  def upvotes
    votes.find(:all,:conditions => {:upvote => true})
  end

  def num_upvotes
    upvotes.length
  end

  def downvotes
    votes.find(:all,:conditions => {:upvote => false})
  end

  def num_downvotes
    downvotes.length
  end

  def net_votes
    num_upvotes - num_downvotes
  end

end
