class Order < ActiveRecord::Base
    attr_accessible :company_id, :customer_id, :title_loan_id, :loan_payment, :amount_paid
    
    belongs_to :company, :class_name => "Company", :foreign_key => "company_id"
    belongs_to :customer, :class_name => "Customer", :foreign_key => "customer_id"
    belongs_to :title_loan
  
  before_create :update_title 
  before_destroy :put_back_to_titles
  
  
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
