class BindingVote < ActiveRecord::Base
  belongs_to :bindable, :polymorphic => true

  include Voteable
end
