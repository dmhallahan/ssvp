class Team < ActiveRecord::Base
  belongs_to :delivery
  belongs_to :vincentian
  
  
  validates_presence_of :team_num,  :delivery_id, :vincentian_id
  validates_uniqueness_of :vincentian_id, :scope => :delivery_id, :message => "This person is already assigned to this delivery."
   
   
   
   def self.team_report
      #deliveries = Delivery.find :all, :conditions => ["delivery_date = ?",  next_delivery_date], :include => [:recipient, :vincentians], :order => 'teams.team_num ASC'
      teams = Team.find :all, :conditions => ["deliveries.delivery_date = ?",  Delivery.next_delivery_date], :include => [{:delivery => :recipient}, :vincentian], :order => 'teams.team_num'
   end
   
  def self.team_nums_for_current_delivery_week
    teams = Team.find :all, :conditions => ["deliveries.delivery_date = ?",  Delivery.next_delivery_date], :joins => :delivery, :order => 'teams.team_num ASC', :select => "DISTINCT team_num"
  end

  def self.next_team_num
    team = Team.find(:first, :order => 'team_num DESC')
    if team.nil?
      next_num = 1
    else
      team.team_num.blank? ? next_num = 1 : next_num = team.team_num + 1 
    end
    next_num
  end
  
#determine if team exists for the given delivery_date
#if delivery_id does not exist, but the team does (all vincentian ids have the same team number for a given date)
#then return that team number
  def self.existing_team_num(vin_ids, del_ids) #takes array of delivery_ids and vincentian_ids
    
    next_delivery_date = Delivery.next_delivery_date
    
    #check for existing team number based on vincentian ids
    unless vin_ids.nil? or next_delivery_date.blank?
     vin_team_nums = vin_ids.map do |vin_id|
        team = Team.find(:first, :conditions => ["Deliveries.delivery_date=? AND Teams.vincentian_id=?", next_delivery_date, vin_id], :joins => :delivery, :order => "id DESC")
        team.team_num unless team.nil?
      end
      

      #determine if all team_nums are the same
      unless vin_team_nums[0].nil?
        first_vin_team = vin_team_nums[0]
        same_vin_team = true
        vin_team_nums.each do |num|
          same_vin_team = false if first_vin_team != num
        end
      end
    end
      
    #check for existing team number based on delivery ids
    unless del_ids.nil? or next_delivery_date.blank?
      delivery_team_nums = del_ids.map do |del_id|
          team = Team.find(:first, :conditions => ["Deliveries.delivery_date=? AND Teams.delivery_id=?", next_delivery_date, del_id], :joins => :delivery, :order => "id DESC")
          team.team_num unless team.nil?
        end
        
        
        #determine if all team_nums are the same
        unless delivery_team_nums[0].nil?
          first_team = delivery_team_nums[0]
          same_team = true
          delivery_team_nums.each do |num|
            same_team = false if first_team != num
          end          
        end
    end
    
    return first_team if same_team 
    return first_vin_team if same_vin_team
      
  end #existing_team_num


  def self.vins_for_team(num)
    vins = Team.find(:all, :conditions => ["team_num =?", num], :include => :vincentian, :select => "DISTINCT vincentian_id")
  end
  
  def self.dels_for_team(num)
    deliveries = Team.find(:all, :conditions => ["team_num = ?", num], :include => [{:delivery => :recipient}], :select => "DISTINCT delivery_id")
  end
  
  
end #class
