class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :email, :street1, :street2, :city, :state, :zipcode, :full_address, :roles, :company_ids
  
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  has_many :employmentships, :dependent => :destroy
  has_many :companies, :through => :employmentships, :dependent => :destroy
  
  validates_presence_of :roles, :message => "can't be blank"
  
  accepts_nested_attributes_for :employmentships, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
  
  
  ROLES = %w[admin employee investor banned]
  
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end
  
  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end
  
  def is?(role)
    roles.include?(role.to_s)
  end

protected
  def password_required?
   !persisted? || password.present? || password_confirmation.present?
 end
  
end
