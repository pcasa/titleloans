class Order < ActiveRecord::Base
    attr_accessible :company_id, :customer_id, :title_loan_id, :loan_payment, :amount_paid, :created_at, :user_id
    
    belongs_to :company, :class_name => "Company", :foreign_key => "company_id"
    belongs_to :customer, :class_name => "Customer", :foreign_key => "customer_id"
    belongs_to :title_loan
  
  before_create :set_loan_payment, :update_title 
  before_destroy :put_back_to_titles
  after_create :run_schedule
  
  validates_presence_of :amount_paid, :message => "can't be blank"
  validate :min_amount_paid, :on => :create
  
  def set_loan_payment
    if title_loan.payment_should_be < self.amount_paid 
      self.loan_payment = (self.amount_paid - title_loan.payment_should_be)
    else 
      self.loan_payment = 0.00
    end
  end
  
  def min_amount_paid
    if !amount_paid.blank? && !title_loan_id.blank? && amount_paid < title_loan.payment_should_be
      errors[:base] << "Minimal Amount Not Paid."
    end
  end
  
  def run_schedule
    title_loan.schedule_loan_tasks(self)
  end
  
private
  def update_title
    title = TitleLoan.find(self.title_loan_id)
    update_loan_amount = (title.loan_amount - self.loan_payment)
    update_paments_made = (title.payments_made + 1)
    title.update_attributes!(:loan_amount => update_loan_amount, :payments_made => update_paments_made)
  end

  def put_back_to_titles
    if TitleLoan.exists?(self.title_loan_id)
      title = TitleLoan.find(self.title_loan_id)
      update_loan_amount = (title.loan_amount + self.loan_payment)
      update_paments_made = (title.payments_made - 1)
      title.update_attributes!(:loan_amount => update_loan_amount, :payments_made => update_paments_made)
    end
  end
end
