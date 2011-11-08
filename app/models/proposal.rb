class Proposal < ActiveRecord::Base
  has_many :votes, :as => :voteable
  has_many :replies
  has_many :ammendments
  
  class << self
    def most_popular
      joins(:votes).group('proposals.id').order('COUNT(votes.id) DESC')
    end
  end
end
