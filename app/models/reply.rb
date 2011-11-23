# A Reply belongs to 
class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :replyable, :polymorphic => true
  
  include Voteable
end
