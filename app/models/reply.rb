# A Reply belongs to 
class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :replyable, :polymorphic => true
  has_many :flags, :as => :flaggable
  has_many :replies, :as => :replyable

  validates :body, :presence => true
  
  include Voteable
end
