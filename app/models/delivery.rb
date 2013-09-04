class Delivery < ActiveRecord::Base
   has_many :teams
   has_many :vincentians, :through => :teams
   belongs_to :recipient 
   
   
   validates_presence_of :delivery_date, :recipient_id
   

  
  
   def self.next_deliveries
     next_delivery_date = Delivery.next_delivery_date
     next_delivery_date.blank? ? nil : deliveries = Delivery.find_all_by_delivery_date(next_delivery_date, :include => [:recipient, :vincentians], :order => "vincentians.first_name ASC")
   end
   
   
   def self.next_delivery_date
      d = Delivery.find(:first, :conditions => ["delivery_date >= ?", Date.today],  :order => 'delivery_date ASC')
      d.blank? ? nil : d.delivery_date
   end
   
   def self.all_previous_deliveries
     deliveries = Delivery.find(:all, :conditions => ["delivery_date <= ?", Date.today], :order => "delivery_date ASC")
  end
   
   def self.next_delivery_recipients
      recipients = Delivery.find_by_sql ["SELECT Recipients.* FROM Recipients, Deliveries WHERE Deliveries.delivery_date = ? AND Deliveries.recipient_id = Recipients.id", next_delivery_date]
    end
    
   def self.this_years_deliveries
     start_of_year = Date.parse("1 Jan #{Date.today.year}")
     deliveries = Delivery.find(:all, :conditions => ["delivery_date >= ? AND delivery_date <= ?", start_of_year, Date.today])
    end
    
  
    

end
