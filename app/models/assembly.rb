require 'uuidable'

class Assembly < ActiveRecord::Base
  has_many :proposals, :foreign_key => :assembly_uuid
  has_many :registration_numbers, :foreign_key => :assembly_uuid
  has_many :taxonomies, :foreign_key => :assembly_uuid

  set_primary_key :uuid

  include UUIDable

  def to_param
    uuid
  end

end
