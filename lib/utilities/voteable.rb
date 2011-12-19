module Voteable
  def self.included(base)
    base.class_eval do
      has_many :votes, :as => :voteable
      after_create do
        upvote(user_id)
      end

      def self.most_popular(limit = false, toplimit = false)
        list = all.sort{ |x,y| y.confidence <=> x.confidence } # this is a really expensive transaction, need to fix

        if !limit && !toplimit
          list
        elsif limit != toplimit && !toplimit
          list.take(limit)
        else
          list.drop(limit).take(toplimit)
        end
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

  ## The following two functions are based off of Reddit's algorithms

  def confidence(bound = :lower)
    n = num_upvotes + num_downvotes
            
    return 0 if n == 0

    z = 1.4395314800662002 

    p_hat = 1.0*num_upvotes/n
    left = p_hat + z*z/(2*n)
    right = z * Math.sqrt( (p_hat*(1-p_hat) + z*z/(4*n)) / n )
    under = 1 + z*z/n
    return (left - right) / under unless bound == :upper
    return (left + right) / under
  end

  def hotness
    s = net_votes
    
    order = Math.log10([s.abs, 1].sort.reverse.first)
    
    sign = (s == 0) ? 0 : s / s.abs # 1, -1, or 0
    
    seconds = Date.new(created_at).strftime('%s').to_i - 1134028003
    
    (order + sign * seconds / 45000).round(7)
  end

end
