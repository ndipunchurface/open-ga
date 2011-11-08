class Ammendment < ActiveRecord::Base
  has_many :votes, :as => :voteable
  belongs_to :proposal
end
