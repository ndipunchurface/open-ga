# Proposals are the heart of this application.
# Anyone can post a proposal, and proposals gain
# popularity by being voted for. A proposal can be
# ammended and replied to by any user. When proposals
# reach enough popularity, a facilitation user can push
# a proposal to being an official proposal of the GA.
# Once the proposal is pushed subsequent votes are binding.
class Proposal < ActiveRecord::Base
  belongs_to :assembly, :foreign_key => :uuid
  belongs_to :user
  has_many :binding_votes, :as => :bindable
  has_many :replies, :as => :replyable
  has_many :flags, :as => :flaggable
  has_many :amendments
  has_many :blocks

  validates :title, :length => {:minimum => 5}
  validates :body, :length => {:minimum => 140}

  include Voteable
  include Flaggable
  include Taggable

  class << self
    # Reorder by most popular proposals.
    #def most_popular(limit = false)
    #  if !limit
    #    joins(:votes).group('proposals.id').order('SUM(votes.upvote) DESC')
    #  else
    #    joins(:votes).group('proposals.id').order('SUM(votes.upvote) DESC').limit(limit)
    #  end
    #end

    # Find a proposals with binding votes
    def binding
      joins(:binding_votes)
    end
  end

  # See: app/models/block.rb
  def block(user_id)
    unless blocks.where(:user_id => user_id).exists?
      blocks.create(:user_id => user_id)
    end
  end
end
