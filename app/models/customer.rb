class Customer < ActiveRecord::Base
  has_many :title_loans
  has_many :orders
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  belongs_to :company, :class_name => "Company", :foreign_key => "company_id"
  
  
    attr_accessible :firstname, :lastname, :email, :street1, :street2, :city, :state, :zipcode, :full_address, :customer_number, :company_id, :title_loans_attributes
    
    accepts_nested_attributes_for :title_loans, :allow_destroy => true, :reject_if => proc { |a| a[:vin].blank? && a[:loan_amount].blank? }
    
  
  before_save :update_full_address
  
  
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
  
end
