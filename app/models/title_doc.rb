class TitleDoc < ActiveRecord::Base
  belongs_to :title_loan
  mount_uploader :name, TitleDocUploader
  
  before_save :set_f_name
  
  def set_f_name
    self.f_name = name
  end
end
