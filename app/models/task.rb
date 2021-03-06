class Task < ActiveRecord::Base
  acts_as_paranoid
  
    attr_accessible :user_id, :assigned_to, :completed_by, :name, :asset_id, :asset_type, :category, :due_at, :deleted_at, :company_id, :force_task
  
  belongs_to  :asset, :polymorphic => true
  belongs_to :insurance_policy
  belongs_to :order
  belongs_to :company
  belongs_to :user
  belongs_to  :assignee, :class_name => "User", :foreign_key => :assigned_to
  belongs_to  :completor, :class_name => "User", :foreign_key => :completed_by
  has_one :comment, :as => :commentable, :dependent => :destroy
  
  validates_presence_of :due_at, :on => :create, :message => "can't be blank"
  
  attr_accessor :reschedule_date, :force_task
  
  before_update :if_user_assigned_delete_task, :check_if_notes, :unless => proc { |a| a.force_task }
  
  # Status based scopes to be combined with the due date and completion time.
  scope :pending,       where("completed_by IS NULL").order("due_at, id")
  scope :assigned,      where("completed_by IS NULL AND assigned_to IS NOT NULL").order("due_at, id")
  scope :completed,     where("completed_by IS NOT NULL").order("completed_by DESC")
  
  # Due date scopes.
  scope :overdue, lambda { where("due_at IS NOT NULL AND due_at < ?", Time.now.midnight).order("due_at ASC")}
  scope :due_today,     lambda { where("due_at >= ? AND due_at < ?", Time.now.midnight, Time.now.midnight.tomorrow).order("due_at ASC")}
  scope :due_tomorrow,  lambda { where("due_at >= ? AND due_at < ?", Time.now.midnight.tomorrow, Time.now.midnight.tomorrow + 1.day).order("due_at ASC")}
  scope :due_this_week, lambda { where("due_at >= ? AND due_at < ?", Time.now.midnight.tomorrow + 1.day, Time.now.next_week).order("due_at ASC") }
  scope :due_next_week, lambda { where("due_at >= ? AND due_at < ?", Time.now.next_week, Time.now.next_week.end_of_week + 1.day).order("due_at ASC")}
  scope :due_later,     lambda { where("due_at IS NULL OR due_at >= ?", Time.now.next_week.end_of_week + 1.day).order("due_at ASC")}
  
  
  CATEGORY = %w[call email follow_up money]
  
  
  
  def mark_as_completed(user_id)
    self.update_attributes(:completed_by => user_id, :deleted_at => Time.now)
  end
  
  def mark_completed_and_msg(user_id, msg)
    if comment.blank?
      Comment.create!(:commentable_type => self.class, :commentable_id => self.id, :content => msg )
    else
      comment.update_attribute(:content, msg)
    end
    self.update_attributes!(:completed_by => user_id, :force_task => true)
  end
  
  def check_if_notes
    if self.comment.blank? || self.comment.content.blank? || self.comment.content.scan(/[\w-]+/).size <= 2
      saved = false
      self.comment.errors[:content] << "You must have a comment and more than 3 words."
      raise ActiveRecord::Rollback
    end
  end
  
  def completed?
    !completed_by.blank?
  end
  
  def if_user_assigned_delete_task
    if completed?
      if deleted_at.blank?
        self.update_attribute(:deleted_at, Time.now)
      end
    end
  end
  
end
