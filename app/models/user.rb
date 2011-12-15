class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,:encryptable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :proposals
  has_many :replies
  has_many :ammendments
  has_many :votes
  has_many :preferences, :as => :preferable
  has_many :authorizations
  has_many :binding_votes
  has_many :blocks
  has_many :flags
  has_many :assemblies

  include Flaggable

  USER = 0
  FACILITATOR = 1
  OWNER = 2

  def ownerships
    authorizations.keep_if { |a| a.role == OWNER }
  end

  ###### Get Authority ###########

  def is_admin?(assembly)
    return false if !authorized?(assembly)
    get_authorization(assembly).role.to_i > USER
  end

  def is_facilitator?(assembly)
    return false if !authorized?(assembly)
    get_authorization(assembly).role.to_i == FACILITATOR
  end

  def is_owner?(assembly)
    return false if !authorized?(assembly)
    get_authorization(assembly).role.to_i == OWNER
  end

  ####### Authorize ############

  def authorize(assembly, role = USER)
    uuid = assembly.class.to_s =~ /String/ ? assembly : assembly.uuid

    authorization = authorizations.where(:assembly_uuid => uuid).first

    unless authorization.nil?
      authorization.role = role
      authorization.save!
    else
      authorizations.create(:assembly_uuid => uuid, :role => role)
    end
  end

  def make_owner(assembly)
    authorize(assembly, OWNER)
  end

  def make_facilitator(assembly)
    authorize(assembly, FACILITATOR)
  end

  def unauthorize(assembly)
    if assembly.class.to_s =~ /String/i
      authorizations.find(:all, :conditions => ["assembly_uuid = ?", assembly]).each {|a| a.destroy}
    else
      authorizations.find(:all, :conditions => ["assembly_uuid = ?", assembly.uuid]).each {|a| a.destroy}
    end
  end

  def authorized?(assembly)
    !get_authorization(assembly).nil?
  end

  def get_authorization(assembly)
    if assembly.class.to_s =~ /String/i
      authorizations.where(:assembly_uuid => assembly).first
    else
      authorizations.where(:assembly_uuid => assembly.uuid).first
    end
  end

  private


end
