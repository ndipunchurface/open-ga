class Preference < ActiveRecord::Base
  belongs_to :preferable, :polymorphic => true
end
