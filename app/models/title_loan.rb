class TitleLoan < ActiveRecord::Base
  belongs_to :customer, :class_name => "Customer", :foreign_key => "customer_id"
  belongs_to :company, :class_name => "Company", :foreign_key => "company_id"
  
  has_one :child, :class_name => "TitleLoan", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "TitleLoan", :foreign_key => "parent_id"
  
  has_many :orders
  has_many :photos, :dependent => :destroy
  has_many :title_docs, :dependent => :destroy
  has_many :tasks, :as => :asset, :dependent => :destroy
  has_many :comments, :as => :commentable
  
  
    attr_accessible :vin, :make, :vin_model, :style, :color, :year, :customer_id, :company_id, :closed_date, :closed_by, :loan_amount, :parent_id, :payments_made, :base_amount, :previous_balance, :tag_number, :due_date, :user_id, :milage, :photos_attributes, :photo_attributes, :formated_created_at
    
    validates_presence_of :customer_id, :vin, :message => "can't be blank", :if => Proc.new { |loan| loan.parent_id.blank? }
    validates_presence_of :loan_amount, :on => :create, :message => "can't be blank"
    validates_presence_of :due_date, :on => :update, :message => "can't be blank"
    validates_numericality_of :year, :message => "is not a number", :if => Proc.new { |loan| loan.parent_id.blank? }
    accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => proc { |obj| obj.blank? }
    
    
    
    before_create :set_base_amount, :check_if_parent, :set_due_date
    after_create :check_if_parent_had_pictures, :set_initial_reminder
  
  
  def formated_created_at
    created_at.strftime('%b %d, %Y %I:%M %p')
  end

  def formated_created_at=(time_str)
     self.created_at = Time.parse(time_str)
  end  
       
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
  
  def check_if_parent_had_pictures
    if !parent_id.blank? && !parent.photos.blank?
      parent.photos.each do |p|
        p.update_attribute(:title_loan_id, self.id)
      end
    end
  end
  
  def amount_borrowed
    if !previous_balance.blank?
      p = (base_amount - previous_balance)
    else
      p = (base_amount - 18)
    end
    return p
  end
  
  #######################################################################################
  # Initial Due Date set
  #######################################################################################
  
  def set_due_date
    if created_at.day >= 29
      y = created_at.year
      m = created_at.next_month.month
      d = 28
      x = Date.new(y, m, d)
    else
      x = created_at.next_month
    end
    self.due_date = x
  end
  
  #######################################################################################
  # Set first reminder
  #######################################################################################
  
  def set_initial_reminder
    msg = "Call #{customer.full_name} about there payment."
    Task.create!(:user_id => user_id, :assigned_to => user_id, :name => msg, :asset_id => self.id, :asset_type => self.class, :company_id => company_id, :category => "call", :due_at => due_date - 2.days)
    clear_parent_tasks unless parent_id.blank?
  end
  
  def clear_parent_tasks
    parent.tasks.each do |pt|
      msg = "Took out a new loan.  New title loan id is #{self.id}"
      pt.mark_completed_and_msg(self.user_id, msg)
    end
  end
  
  #######################################################################################
  # Work with tasks after payment made
  #######################################################################################
  
  def schedule_loan_tasks(order)
    comment = "system note - Made payment on #{order.created_at}"
    msg = "Call #{customer.full_name} about there payment."
    new_date = self.due_date.next_month
    tasks.each do |t|
      t.mark_completed_and_msg(order.user_id, comment)
    end
    self.update_attribute(:due_date, new_date)
    Task.create!(:user_id => user_id, :assigned_to => user_id, :name => msg, :asset_id => self.id, :asset_type => self.class, :company_id => company_id, :category => "call", :due_at => new_date - 2.days)
  end
     
  
  #######################################################################################
  # Get payment info depending how many payments have been made
  #######################################################################################
    
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
  
  def late_fees
    if due_date < Date.today
      percent = get_percentage(payments_made)
      p = ((base_amount / 30) * percent).ceil
      days_late = ((((Date.today.to_time - due_date.to_time) / 60) / 60) / 24)
      late_fee = p * days_late
    else
      late_fee = 0
    end
    return late_fee.ceil
  end
  
  def estimate_payments(number)
    if ((base_amount <= 1499.99) && number <= 3) || ((base_amount == 1500..1999.99) && number <= 2) || ((base_amount == 2000..2999.99) && number <= 1)
      payment_should_be = (base_amount * 0.15)
    else
      payment_should_be = (base_amount * 0.10)
    end
    return payment_should_be.ceil
  end
  
  def get_percentage(payments_made)
    if ((base_amount <= 1499.99) && payments_made <= 3) || ((base_amount == 1500..1999.99) && payments_made <= 2) || ((base_amount == 2000..2999.99) && payments_made <= 1)
      percentage_should_be = 0.15
    else
      percentage_should_be = 0.10
    end
    return percentage_should_be
  end
  
  def estimate_late_payment_fee(est_percent)
    p = (base_amount / 30) * est_percent
    return p.ceil
  end
  
    
  def closed?
    !closed_date.blank?
  end
  
  
end
