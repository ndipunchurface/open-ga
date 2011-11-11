# Proposals are the heart of this application.
# Anyone can post a proposal, and proposals gain
# popularity by being voted for. A proposal can be
# ammended and replied to by any user. When proposals
# reach enough popularity, a facilitation user can push
# a proposal to being an official proposal of the GA.
# Once the proposal is pushed subsequent votes are binding.
class Proposal < ActiveRecord::Base
  has_many :votes, :as => :voteable
  has_many :replies, :as => :replyable
  has_many :amendments

  include Voteable
  
  class << self
    # Reorder by most popular proposals.
    def most_popular
      joins(:votes).group('proposals.id').order('SUM(votes.upvote) DESC')
    end
  end
end
