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

  def is_admin?
    is_admin
  end

  def authorize(assembly)
    if assembly.class.to_s =~ /String/i
      authorizations.create(:assembly_uuid => assembly)
    else
      authorizations.create(:assembly_uuid => assembly.uuid)
    end
  end

  def unauthorize(assembly)
    if assembly.class.to_s =~ /String/i
      authorizations.find(:all, :conditions => ["assembly_uuid = ?", assembly]).each {|a| a.destroy}
    else
      authorizations.find(:all, :conditions => ["assembly_uuid = ?", assembly.uuid]).each {|a| a.destroy}
    end
  end

  def authorized?(assembly)
    if assembly.class.to_s =~ /String/i
      authorizations.find(:all, :conditions => ["assembly_uuid = ?", assembly]).length > 0
    else
      authorizations.find(:all, :conditions => ["assembly_uuid = ?", assembly.uuid]).length > 0
    end
  end
end
