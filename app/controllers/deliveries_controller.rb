class DeliveriesController < ApplicationController
  
    require 'lib/Tools.rb'
    include Tools #helper module
  
    before_filter :set_current_section #controls display of navigation tabs
    
    def set_current_section
      @current_section = "deliveries"
    end
  
  
protect_from_forgery :except => [:post_data]


# Don't forget to edit routes if you're using RESTful routing (see config/routes.rb)
  def post_data
    
    if params[:oper] == "del"
      Delivery.find(params[:id]).destroy
    else
      delivery_params = { :delivery_date => params[:delivery_date],
                                    :comment => params[:comment], 
                                    :bags => params[:bags],
                                    :recipient_id => params[:recipient_id]
                                }
                                  
      if params[:id] == "_empty"
        delivery = Delivery.create(delivery_params)
      else
        delivery = Delivery.find(params[:id])
        delivery.update_attributes(delivery_params)
      end
    end
    
    # If you need to display error messages
    err = ""
    if delivery
      delivery.errors.entries.each do |error|
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

    deliveries = Delivery.find(:all) do
      if params[:_search] == "true"
        delivery_date =~ "%#{params[:delivery_date]}%" if params[:delivery_date].present?
        comment =~ "%#{params[:comment]}%" if params[:comment].present?                
        bags =~ "%#{params[:bags]}%" if params[:bags].present?
        recipient_id =~ "%#{params[:recipient_id]}%" if params[:recipient_id].present?
      end
      paginate :page => params[:page], :per_page => params[:rows]      
      order_by "#{params[:sidx]} #{params[:sord]}"
    end
    if request.xhr?
      render :json => deliveries.to_jqgrid_json([:delivery_date, "recipient.full_name", :comment, :bags ], params[:page], params[:rows], deliveries.total_entries) and return
    end
  end
  

  
  # GET /deliveries
  def new
    #uses post_data instead
  end
  
  
  # POST /deliveries
  def create
    #uses post_data instead
  end
  
  def show
    #not used
  end
  
  
  
  def map
      recipients = Delivery.next_delivery_recipients 
      if recipients.blank?
        flash[:notice] = 'No recipients exist for next delivery.'
        redirect_to :action => 'index'
      end

  
      recipient_info =  recipients.map do |r|
                    begin 
                      {:id => r.id, :location => [r.address.strip, r.city.strip].join(", "), :name => r.first_name + " " + r.last_name}
                    rescue
                        flash[:notice] = "This recipient has an error with the name or address: #{}"
                        redirect_to :action => 'index'
                    end
                  end
        
     recipient_info.each do |r|
          coords = get_latlng(r[:location]) #takes a string address and returns the latitude and longitude as array or nil on fail  (lib/Toolbox.rb)
          r[:lat] = coords[0]
          r[:lon] = coords[1]
        end
  
    
     @info= recipient_info     
  end
  

  #create pdf report for central office
  def central_report
    prawnto :prawn=>{:page_layout=>:landscape} 
    
    deliveries = Delivery.this_years_deliveries
    if deliveries.blank?
      flash[:notice] = "There are no deliveries to report."
      redirect_to :action => 'index'
    else
    @report = deliveries.map do |delivery|
                      [
                      delivery.delivery_date,
                      delivery.recipient.full_name,
                      delivery.recipient.phone_number,
                      delivery.recipient.address,
                      delivery.recipient.apt,
                      delivery.recipient.adults,
                      delivery.recipient.children,
                      join_list(delivery.vincentians),
                      delivery.bags,
                      delivery.comment
                      ]
                    end
    end
  end
  

  
 #GET
  def admin_report
     prawnto :prawn=>{:page_layout=>:portrait} 
     
    @current_delivery_date = Delivery.next_delivery_date
    deliveries = Delivery.next_deliveries
    
    if deliveries.blank? or @current_delivery_date.blank?
      flash[:notice] = "There are no deliveries scheduled."
      redirect_to :action => 'index'
    else
    @report = deliveries.map do |delivery|
                                            [
                                            join_list(delivery.vincentians),
                                            delivery.recipient.full_name,
                                            " ",
                                            ]
                                          end
    
      respond_to do |format|
        format.pdf #admin_report.pdf.prawn
        end
    end
  end
  
  #GET
  def delivery_report
     #prawnto :prawn=>{:page_layout=>:landscape} 
     
    @current_delivery_date = Delivery.next_delivery_date
    #deliveries = Delivery.team_report
    #teams = Delivery.team_report
    team_nums = Team.team_nums_for_current_delivery_week
    
    if team_nums.blank? or @current_delivery_date.blank?
      flash[:notice] = "There are no deliveries scheduled."
      redirect_to :action => 'index'
    else
    #group results by team
    @report = []
    
    team_nums.each do |num|
          vins = Team.find(:all, :conditions => ["team_num =?", num.team_num], :include => :vincentian, :select => "DISTINCT vincentian_id")
          deliveries = Team.find(:all, :conditions => ["teams.team_num = ?", num.team_num], :include => [{:delivery => :recipient}], :select => "DISTINCT delivery_id")
          info = []
          info << [vins, deliveries] 
         @report << info
        end
       
      #respond_to do |format|
      #  format.html
      #  format.pdf #delivery_report.pdf.prawn
      #  end
      end
      
  end
  
  
  
  private
  
  #takes an array and returns a string 
  def join_list(vins)
    a = vins.map do |v|
            v.full_name
          end
    a.join("\n")
  end
  
  
end