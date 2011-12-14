class Document < ActiveRecord::Base
  belongs_to :documentable, :polymorphic => true
  has_many :replies, :as => :replyable
end
