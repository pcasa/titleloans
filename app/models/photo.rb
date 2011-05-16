class Photo < ActiveRecord::Base
  belongs_to :title_loan
  mount_uploader :image, PhotoUploader
  
end
