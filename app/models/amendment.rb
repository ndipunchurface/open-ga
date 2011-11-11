# The Amendment class is just a post that belongs to a Proposal.
# A user will post an amendment when they feel a proposal could
# be improved. Amendments are voteable.
class Amendment < ActiveRecord::Base
  has_many :votes, :as => :voteable
  has_many :replies, :as => :replyable
  belongs_to :proposal
  belongs_to :user

  include Voteable
end
