# A Reply belongs to 
class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :replyable, :polymorphic => true
  has_many :flags, :as => :flaggable

  validates :body, :presence => true
  
  include Voteable
end
