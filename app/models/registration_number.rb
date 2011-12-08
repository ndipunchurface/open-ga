require 'uuidable'

# The Registration Number is a unique number that a user
# inputs at registration time. Once the number is used, it is
# burned and cannot be used to register again. The Registration
# Number's primary key is a UUID random key.
#
# There will be associated Rake tasks to build numbers and print
# registration cards.
class RegistrationNumber < ActiveRecord::Base
  belongs_to :assembly, :foreign_key => :assembly_uuid

  include UUIDable
  
  class << self
    # Burn the number from the class level: RegistrationNumber.burn_number('123-456-789')
    def burn_number(n)
      num = find_by_uuid(n)
      num.active = false
      num.save
    end

    def find_by_uuid(n)
      where(:uuid => n).first
    end
  end

  # Burn number from the instance level:
  # @registration_num = RegistrationNumber.find_by_uuid('123-456-789')
  # @registration_num.burn_number
  def burn_number
    self.active = false
    save
  end

end
