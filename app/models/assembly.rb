require 'uuidable'

# An Assembly houses all of the proposals, amendments and replies.
# Users can create an assembly, and then have others register for it.
# A user can register for an unlimited number of assemblies as long as
# they have a valid registration number for EACH assembly.
# See: Authorization
class Assembly < ActiveRecord::Base
  attr_accessible :name, :category_id, :description, :city, :state, :super_majority, :theme, 
    :web_address, :public_email, :public_phone, :flag_threshold, :block_threshold 

  has_many :proposals, :foreign_key => :assembly_uuid
  has_many :registration_numbers, :foreign_key => :assembly_uuid
  has_many :taxonomies, :foreign_key => :assembly_uuid
  has_one :assembly_document_repository, :foreign_key => :assembly_uuid
  has_many :documents, :through => :assembly_document_repository
  has_one :alias, :foreign_key => :assembly_uuid
  belongs_to :user
  belongs_to :category

  after_save :authorize_owner
  after_save :alias_assembly
  after_save :create_assembly_document_repository

  set_primary_key :uuid

  include UUIDable

  def self.find_by_uuid_or_alias(string)
    find(string)
  rescue ActiveRecord::RecordNotFound
    assembly_alias = Alias.where(:name => string).first
    includes(:proposals).find(assembly_alias.assembly_uuid)
  end

  def to_param
    uuid
  end

  private

  def authorize_owner
    user = User.find(user_id)
    user.make_owner(uuid)
  end

  def alias_assembly
    slug = name.downcase.gsub(/[\W\s]/,'_')
    create_alias(:name => slug)
  end
end
