class TitleLoan < ActiveRecord::Base
  belongs_to :customer, :class_name => "Customer", :foreign_key => "customer_id"
  belongs_to :company, :class_name => "Company", :foreign_key => "company_id"
  
  has_one :child, :class_name => "TitleLoan", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "TitleLoan", :foreign_key => "parent_id"
  
  has_many :orders
  
  
    attr_accessible :vin, :make, :vin_model, :style, :color, :year, :customer_id, :company_id, :closed_date, :closed_by, :loan_amount, :parent_id, :payments_made, :base_amount, :previous_balance, :tag_number, :due_date
    
    validates_presence_of :customer_id, :loan_amount, :vin, :message => "can't be blank", :if => Proc.new { |loan| loan.parent_id.blank? }
    validates_numericality_of :year, :message => "is not a number", :if => Proc.new { |loan| loan.parent_id.blank? }
    
    
    before_create :set_base_amount, :check_if_parent
    
    
  def set_base_amount
    if parent_id.blank?
      # add $18 for title fees
      y = 18
    else
      y = 0
    end
    self.base_amount = (loan_amount + previous_balance + y)
    x = loan_amount
    self.loan_amount = (x + previous_balance + y)
  end
  
  def check_if_parent
    unless parent_id.blank?
      self.vin = parent.vin
      self.make = parent.make
      self.vin_model = parent.vin_model
      self.style = parent.style
      self.color = parent.color
      self.year = parent.year
      parent.update_attribute(:closed_date, Time.now)
    end
  end
     
    
  def payment
    loan_amount / 12
  end
  
  def payment_should_be
    if payments_made.blank? || payments_made <= 2
      if ((base_amount <= 1499.99) && payments_made <= 2) || ((base_amount == 1500..1999.99) && payments_made <= 1) || ((base_amount == 2000..2999.99) && payments_made <= 0)
        payment_should_be = (base_amount * 0.15)
      else
          payment_should_be = (base_amount * 0.10)
      end
    else
      payment_should_be = (base_amount * 0.10)
    end  
    return payment_should_be.ceil
  end
  
  def estimate_payments(number)
    if ((base_amount <= 1499.99) && number <= 3) || ((base_amount == 1500..1999.99) && number <= 2) || ((base_amount == 2000..2999.99) && number <= 1)
      payment_should_be = (base_amount * 0.15)
    else
      payment_should_be = (base_amount * 0.10)
    end
    return payment_should_be
  end
  
    
  def closed?
    !closed_date.blank?
  end
  
  
end
