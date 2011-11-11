require 'active_support/secure_random'
require 'rubygems'
require 'uuidtools'

class RegistrationNumber < ActiveRecord::Base
  before_create :set_uuid
  set_primary_key :id

  class << self
    def burn_number(n)
      num = find(n)
      num.active = false
      num.save
    end
  end

  def burn_number
    self.active = false
    save
  end

  private

  def set_uuid
    self.id = UUIDTools::UUID.random_create.to_s
  end
end
