class Vincentian < ActiveRecord::Base
  has_many :teams
  has_many :deliveries, :through => :teams
  
  validates_presence_of :first_name, :last_name, :phone_number
  validates_length_of :phone_number, :is => 12, :message => "should be like this 123-123-1234"


  def full_name
    self.first_name + " " + self.last_name
  end
  

end
