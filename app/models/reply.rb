class Reply < ActiveRecord::Base
  has_many :votes, :as => :voteable
  belongs_to :proposal
  belongs_to :user
  
  include Voteable
end
