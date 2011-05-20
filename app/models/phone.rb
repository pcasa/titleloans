class Phone < ActiveRecord::Base
  # attr_accessible  :phone_number, :phone_type, :customer_id, :disabled
  
  belongs_to :customer
  
  
  PHONETYPE = %w[home work mobile]
end
