# A Reply belongs to 
class Reply < ActiveRecord::Base
  has_many :votes, :as => :voteable
  belongs_to :user
  belongs_to :replyable, :polymorphic => true
  
  include Voteable
end
