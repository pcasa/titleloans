class Company < ActiveRecord::Base
  has_friendly_id :name, :use_slug => true
  
  has_many :titles
    attr_accessible :name, :cached_slug, :phone, :street1, :street2, :city, :state, :zipcode, :full_address
    
    validates_uniqueness_of :name, :message => "must be unique"
  
  before_save :update_full_address
    
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
