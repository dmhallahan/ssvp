class Recipient < ActiveRecord::Base
  has_many :deliveries
  
  def full_name
    fn = first_name + " " + last_name
    if fn.nil?
      ""
    else
      fn
    end
  end
  
  def before_validation
   #self.phone_number = self.phone_number.gsub(/[^0-9]/, "")
   self.apt = self.apt.gsub(/[^A-Za-z0-9_]/, "") unless self.apt.blank? 
  end
    
  validates_presence_of :first_name, :last_name, :address
  #validates_uniqueness_of :phone_number, :allow_nil => true
  #UNIQUE INDEX for apt and address exists in the database to prevent duplicate addresses
  

  

  
  
end
