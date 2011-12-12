# The Binding Vote is meant to be a binding decision that
# is respected by the sovereign body (in the case of an
# Occupation, this would be the General Assembly). Normal
# upvoting and downvoting is considered to be a straw poll
# by comparison.
class BindingVote < ActiveRecord::Base
  belongs_to :bindable, :polymorphic => true
  belongs_to :user

  include Voteable
end
