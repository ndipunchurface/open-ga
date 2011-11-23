require 'active_support/secure_random'
require 'rubygems'
require 'uuidtools'

module UUIDable
  def self.included(base)
    base.class_eval do
      before_create :set_uuid

      private

      # Create the random UUID
      def set_uuid
        self.uuid = UUIDTools::UUID.random_create.to_s
      end
    end
  end
end
