require 'uuidable'

class Assembly < ActiveRecord::Base
  has_many :proposals
  has_many :preferences, :as => :preferable

  include UUIDable
end
