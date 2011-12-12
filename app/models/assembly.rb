require 'uuidable'

# An Assembly houses all of the proposals, amendments and replies.
# Users can create an assembly, and then have others register for it.
# A user can register for an unlimited number of assemblies as long as
# they have a valid registration number for EACH assembly.
# See: Authorization
class Assembly < ActiveRecord::Base
  has_many :proposals, :foreign_key => :assembly_uuid
  has_many :registration_numbers, :foreign_key => :assembly_uuid
  has_many :taxonomies, :foreign_key => :assembly_uuid
  has_one :alias, :foreign_key => :assembly_uuid
  belongs_to :user

  after_save :authorize_owner
  after_save :alias_assembly

  set_primary_key :uuid

  include UUIDable

  def to_param
    uuid
  end

  private

  def authorize_owner
    Authorization.create(:user_id => user_id, :assembly_uuid => uuid)
  end

  def alias_assembly
    slug = name.downcase.gsub(/[\W\s]/,'_')
    build_alias(:name => slug)
  end
end
