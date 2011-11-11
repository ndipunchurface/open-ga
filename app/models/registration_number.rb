require 'active_support/secure_random'
require 'rubygems'
require 'uuidtools'

# The Registration Number is a unique number that a user
# inputs at registration time. Once the number is used, it is
# burned and cannot be used to register again. The Registration
# Number's primary key is a UUID random key.
#
# There will be associated Rake tasks to build numbers and print
# registration cards.
class RegistrationNumber < ActiveRecord::Base
  before_create :set_uuid
  set_primary_key :id

  class << self
    # Burn the number from the class level: RegistrationNumber.burn_number('123-456-789')
    def burn_number(n)
      num = find(n)
      num.active = false
      num.save
    end
  end

  # Burn number from the instance level:
  # @registration_num = RegistrationNumber.find('123-456-789')
  # @registration_num.burn_number
  def burn_number
    self.active = false
    save
  end

  private

  # Create the random UUID
  def set_uuid
    self.id = UUIDTools::UUID.random_create.to_s
  end
end
