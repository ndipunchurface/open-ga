module Flaggable

  def flag(user_id)
    unless flags.where(:user_id => user_id).exists?
      flags.create(:user_id => user_id)
    end
  end

  def is_flagged?
    flags.length > 0
  end

  def num_flagged
    flags.length
  end
end
