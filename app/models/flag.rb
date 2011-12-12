# A Flag is instated when the content of a proposal, amendment
# or reply is highly offensive or inappropriate. Examples would be
# racism, sexism, excessive vulgarity, spam, trolling, etc.
class Flag < ActiveRecord::Base
  belongs_to :flaggable, :polymorphic => true
  belongs_to :user

  class << self
    def find_by_flaggable(flaggable_model)
      where(:flaggable_id => flaggable_model.id, :flaggable_type => flaggable_model.class.to_s)
    end
  end
end
