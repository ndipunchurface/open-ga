class Taxonomy < ActiveRecord::Base
  belongs_to :taggable, :polymorphic => true
  belongs_to :tag
  belongs_to :assembly, :foreign_key => :assembly_uuid
end
