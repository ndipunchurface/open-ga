module Flaggable

  def flag
    flags.create
  end

  def is_flagged?
    flags.length > 0
  end

  def num_flagged
    flags.length
  end
end
