class BindingVote < ActiveRecord::Base
  belongs_to :bindable, :polymorphic => true
  belongs_to :user

  include Voteable
end
