require 'uuidable'

class Assembly < ActiveRecord::Base
  has_many :proposals
  has_many :users
  has_many :preferences, :as => :preferable

  include UUIDable

  def to_param
    uuid
  end

end
