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

  belongs_to :assembly
  
  def is_admin?
    is_admin
  end
end
