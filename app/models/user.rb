class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :email, :street1, :street2, :city, :state, :zipcode, :full_address, :roles, :company_ids, :username
  
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  has_many :employmentships, :dependent => :destroy
  has_many :companies, :through => :employmentships, :dependent => :destroy
  
  validates_presence_of :roles, :username, :message => "can't be blank"
  
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
  def self.find_for_database_authentication(conditions)
   username = conditions.delete(:username)
   where(conditions).where(["username = :value", { :value => username }]).first
  end
 

  # Attempt to find a user by it's email. If a record is found, send new
  # password instructions to it. If not user is found, returns a new user
  # with an email not found error.
  def self.send_reset_password_instructions(attributes={})
   recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
   recoverable.send_reset_password_instructions if recoverable.persisted?
   recoverable
  end 

  def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
   case_insensitive_keys.each { |k| attributes[k].try(:downcase!) }

   attributes = attributes.slice(*required_attributes)
   attributes.delete_if { |key, value| value.blank? }

   if attributes.size == required_attributes.size
     if attributes.has_key?(:username)
        login = attributes.delete(:username)
        record = find_record(login)
     else  
       record = where(attributes).first
     end  
   end  

   unless record
     record = new

     required_attributes.each do |key|
       value = attributes[key]
       record.send("#{key}=", value)
       record.errors.add(key, value.present? ? error : :blank)
     end  
   end  
   record
  end

  def self.find_record(username)
   where(attributes).where(["username = :value", { :value => username }]).first
  end

  def password_required?
   !persisted? || password.present? || password_confirmation.present?
  end

end
