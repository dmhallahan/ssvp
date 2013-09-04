class TeamsController < ApplicationController
      
    before_filter :set_current_section
    
    def set_current_section
      @current_section = "teams"
    end
  
  
protect_from_forgery :except => [:post_data]


# Don't forget to edit routes if you're using RESTful routing (see config/routes.rb)
  def post_data
   
    if params[:oper] == "del"
      Team.find(params[:id]).destroy
    else
      team_params = { :team_num => params[:team_num],
                                    :delivery_id => params[:delivery_id], 
                                    :vincentian_id => params[:vincentian_id]
                            }
                                  
      if params[:id] == "_empty"
        team = Team.create(team_params)
      else
        team = Team.find(params[:id])
        team.update_attributes(team_params)
      end
    end
    
# If you need to display error messages
    err = ""
    if team
      team.errors.entries.each do |error|
        err << "#{error[0]} #{error[1]}"
      end
    end
    
    if err.blank? 
      flash.now[:notice] = "Update successful."
    else
      flash.now[:notice] =  "#{err}"
    end
    
   render :text => flash.now[:notice]
   
  end

  def index
    
    teams = Team.find(:all, :include => [:delivery, :vincentian], :order => "deliveries.delivery_date DESC, teams.team_num ASC, vincentians.first_name ASC") do
      if params[:_search] == "true"
        delivery_id =~ "%#{params[:delivery_id]}%" if params[:delivery_id].present?
        vincentian_id =~ "%#{params[:vincentian_id]}%" if params[:vincentian_id].present?                
        recipient_id=~ "%#{params[:recipient_id]}%" if params[:recipient_id].present?  
      end
      paginate :page => params[:page], :per_page => params[:rows]      
      order_by "#{params[:sidx]} #{params[:sord]}"
    end
    if request.xhr?
      render :json => teams.to_jqgrid_json(["delivery.delivery_date","delivery.recipient.full_name", "vincentian.full_name", :team_num], params[:page], params[:rows], teams.total_entries) and return      
    end
  end
  

  def new
     # Queries are here for clarity purposes in this demo
    # It's of course a better idea to create a method in your model

    deliveries = Delivery.find(:all, :include => :recipient) do
      if params[:_search] == "true"
        delivery_date =~ "%#{params[:delivery_date]}%" if params[:delivery_date].present?
        #recipient_id =~ "%#{params[:recipient_id]}%" if params[:recipient_id].present?
      end
      paginate :page => params[:page], :per_page => params[:rows]      
      order_by "#{params[:sidx]} #{params[:sord]}"
    end
    if request.xhr?
      render :json => deliveries.to_jqgrid_json([:delivery_date, "recipient.full_name", :comment], params[:page], params[:rows], deliveries.total_entries) and return
    end
  end
  

  def vincentians
    # returns list of vincentians for master deliveries list @ /teams/new
    
    if params[:id].present?
      vincentians = Delivery.find(params[:id]).vincentians.find(:all) do
        paginate :page => params[:page], :per_page => params[:rows]      
        order_by "#{params[:sidx]} #{params[:sord]}"        
      end
      total_entries = vincentians.total_entries
    else
      vincentians = []
      total_entries = 0
    end
    if request.xhr?
      render :json => vincentians.to_jqgrid_json([:first_name,:last_name, :notes], params[:page], params[:rows], total_entries) and return
    end
  end
  
  def vincentians_select
    # returns list of vincentians for selection of team @ /teams/new
    
    vincentians = Vincentian.find(:all) do
      if params[:_search] == "true"
        last_name =~ "%#{params[:first_name]}%" if params[:first_name].present?                
        notes =~ "%#{params[:notes]}%" if params[:notes].present?
      end
      paginate :page => params[:page], :per_page => params[:rows]      
      order_by "#{params[:sidx]} #{params[:sord]}"        
    end

    if request.xhr?
      render :json => vincentians.to_jqgrid_json([:first_name, :last_name, :notes], params[:page], params[:rows], vincentians.total_entries) and return
    end
  end
  
  
  
  #ids from Vincentians and Deliveries table at teams/new
  def create

  team_errors = [] #array of errors for the create operation 

    vin_ids_hash = params.reject { |k,v| k.to_s[0,6] != 'vin_id' } #grab vincentian ids
    del_ids_hash = params.reject { |k,v| k.to_s[0,6] != 'del_id' } #grab delivery ids

    #validate
    if vin_ids_hash.blank? or del_ids_hash.blank? 
      team_errors << "Select both vincentian(s) and deliveries(s)."
    else
      vin_ids = vin_ids_hash.values #grab just the values from the hash
      del_ids = del_ids_hash.values #grab just the values from the hash     
    end

    
    existing_team_num = Team.existing_team_num(vin_ids, del_ids) #check for existing team
    next_team_num = Team.next_team_num if existing_team_num.blank?
    
    if team_errors.blank?   
          vin_ids.each do |vin_id|     
            del_ids.each do |del_id|
              existing_team_num.blank? ? team_num = next_team_num : team_num = existing_team_num 
                  new_team = Team.new(
                    :delivery_id => del_id, :team_num => team_num, :vincentian_id => vin_id)   
                    new_team.save
                    new_team.errors.each_full do |msg|
                        team_errors << msg
                    end
            end
          end
    end

      
    if team_errors.blank?
      flash.now[:notice] = 'Team(s) successfully created. Refresh the table to see the changes.'
    else
      flash.now[:notice] = "#{team_errors.join(" ")}"
    end
    
  end #end create
      
      
      
      
  def show
    #not used
  end
  
  

  
end #end class
  