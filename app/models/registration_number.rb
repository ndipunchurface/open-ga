require 'active_support/secure_random'

class RegistrationNumber < ActiveRecord::Base
  before_create :randomize_number

  class << self
    def burn_number(n)
      num = find_by_number(n)
      num.active = false
      num.save
    end
  end

  def burn_number
    self.active = false
    save
  end

  def exists?(n)
    !RegistrationNumber.find_by_number(n).nil?
  end

  private

  def random_number
    SecureRandom.hex(16)
  end

  def randomize_number
    self.number = random_number
    if exists?(self.number)
      randomize_number
    end
  end
end
