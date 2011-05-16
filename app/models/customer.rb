class Customer < ActiveRecord::Base
  has_many :title_loans
  has_many :orders
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :tasks, :as => :asset, :dependent => :destroy
  has_many :addresses, :as => :addressable, :dependent => :destroy
  
  belongs_to :company, :class_name => "Company", :foreign_key => "company_id"
  
  
    attr_accessible :firstname, :lastname, :email, :street1, :street2, :city, :state, :zipcode, :full_address, :customer_number, :company_id, :c_height, :race, :gender, :dob, :title_loans_attributes
    
    accepts_nested_attributes_for :title_loans, :allow_destroy => true, :reject_if => proc { |a| a[:vin].blank? && a[:loan_amount].blank? }
    
  
  before_validation(:on => :create){ make_customer_number }
  before_save :update_full_address
  before_update :check_if_address_changed
  
  validates_length_of :c_height, :gender, :within => 3..16, :message => "must be present"
  validates_length_of :race, :within => 3..64, :message => "must be present"
  validates_presence_of :dob, :on => :create, :message => "can't be blank"
  
  
  include ActiveModel::Dirty

  def firstname=(firstname)
     write_attribute(:firstname, firstname.upcase)
   end
  
   def lastname=(lastname)
      write_attribute(:lastname, lastname.upcase)
    end
  
  def make_customer_number(size = 8)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z}
    code = (0...size).map{ charset.to_a[rand(charset.size)] }.join
    self.customer_number = code
  end
  
  
  def full_name
    firstname + " " + lastname
  end
  
  def update_full_address
    unless self.street2.blank?
      street = self.street1 + "<br />" + self.street2 + "<br />" 
    else 
      street = self.street1 + "<br />"
    end
    citystatezip = self.city + ", " + self.state + " " + self.zipcode
    self.full_address = street + citystatezip
  end
  
  def check_if_address_changed
    if self.street1_changed? || self.street2_changed? || self.city_changed? || self.state_changed? || self.zipcode_changed?
      Address.create!(:street1 => self.street1_was, :street2 => self.street2_was, :city => self.city_was, :state => self.state_was, :zipcode => self.zipcode_was, :addressable_type => "Customer", :addressable_id => self.id, :full_address => self.full_address, :address_type => "Customer")
    end
  end
  
end
