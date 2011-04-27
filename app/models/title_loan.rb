class TitleLoan < ActiveRecord::Base
  belongs_to :customer, :class_name => "Customer", :foreign_key => "customer_id"
  belongs_to :company, :class_name => "Company", :foreign_key => "company_id"
  
  has_one :child, :class_name => "TitleLoan", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "TitleLoan", :foreign_key => "parent_id"
  
  has_many :orders
  
  
    attr_accessible :vin, :make, :model, :style, :color, :year, :customer_id, :company_id, :closed_date, :closed_by, :loan_amount, :parent_id, :payments_made
    
    validates_presence_of :customer_id, :loan_amount, :vin, :message => "can't be blank"
    validates_numericality_of :year, :message => "is not a number"
    
  def payment_should_be
    if payments_made.blank? || payments_made <= 3
      payment_should_be = (loan_amount / 12) + (loan_amount * 0.15)
    else
      payment_should_be = (loan_amount / 12) + (loan_amount * 0.10)
    end  
    return payment_should_be
  end
  
    
  def closed?
    !closed_date.blank?
  end
  
  
end
