class Flag < ActiveRecord::Base
  belongs_to :flaggable, :polymorphic => true

  class << self
    def find_by_flaggable(flaggable_model)
      where(:flaggable_id => flaggable_model.id, :flaggable_type => flaggable_model.class.to_s)
    end
  end
end
