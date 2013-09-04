class RecipientsController < ApplicationController
    
    before_filter :set_current_section
    
    def set_current_section
      @current_section = "recipients"
    end

 protect_from_forgery :except => [:post_data]
 

 
   # Don't forget to edit routes if you're using RESTful routing (see config/routes.rb)
  def deliveries
    
    if params[:id].present?
      deliveries = Recipient.find(params[:id]).deliveries.find(:all) do
        paginate :page => params[:page], :per_page => params[:rows]      
        order_by "#{params[:sidx]} #{params[:sord]}"        
      end
      total_entries = deliveries.total_entries
    else
      deliveries = []
      total_entries = 0
    end
    if request.xhr?
      render :json => deliveries.to_jqgrid_json([:delivery_date, :bags, :comment], params[:page], params[:rows], total_entries) and return
    end
  end

# Don't forget to edit routes if you're using RESTful routing (see config/routes.rb)
  def post_data
        
    if params[:oper] == "del"
      Recipient.find(params[:id]).destroy
    else
      recipient_params = { :first_name => params[:first_name],
                                    :last_name => params[:last_name], 
                                    :phone_number => params[:phone_number],
                                    :address => params[:address],                      
                                    :apt => params[:apt],
                                    :city => params[:city],
                                    :adults => params[:adults],
                                    :children => params[:children],
                                    :notes => params[:notes],
                                    :delivery_notes => params[:delivery_notes]
                                  }
                                  
      if params[:id] == "_empty"
        recipient = Recipient.create(recipient_params)
      else
        recipient = Recipient.find(params[:id])
        begin
          recipient.update_attributes(recipient_params)
        rescue ActiveRecord::StatementInvalid #handles apt/address unique index error
          recipient.errors.add(:address, "Check that the Address and Apt don't already exist.")
        end
      end
    end
    
    # If you need to display error messages
    err = ""
    if recipient
      recipient.errors.entries.each do |error|
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

    recipients = Recipient.find(:all) do
      if params[:_search] == "true"
        first_name =~ "%#{params[:first_name]}%" if params[:first_name].present?
        last_name =~ "%#{params[:last_name]}%" if params[:last_name].present?                
        phone_number =~ "%#{params[:phone_number]}%" if params[:phone_number].present?
        address =~ "%#{params[:address]}%" if params[:address].present?
        postal_code =~ "%#{params[:apt]}%" if params[:apt].present?
        city =~ "%#{params[:city]}%" if params[:city].present?
        adults =~ "%#{params[:adults]}%" if params[:adults].present?
        children =~ "%#{params[:children]}%" if params[:children].present?
        notes =~ "%#{params[:notes]}%" if params[:notes].present?
        delivery_notes =~ "%#{params[:delivery_notes]}%" if params[:delivery_notes].present?
      end
      paginate :page => params[:page], :per_page => params[:rows]      
      order_by "#{params[:sidx]} #{params[:sord]}"
    end
    
    #get the from_address for the distribution center
    @from_destination = "834 Raymo Road Windsor Ontario"
    
     
    if request.xhr?
      render :json => recipients.to_jqgrid_json([:first_name,:last_name,:phone_number, :address, :apt, :city, :adults, :children, :notes, :delivery_notes], params[:page], params[:rows], recipients.total_entries) and return
    end
  end
  
def show
  map if params[:id] == 'map' #required for REST routes... check this... shouldn't have to do this.
end
  
#hidden form input submitted with recipient_id
#adjust routes.rb for non-standard REST methods
def map
  @recipient = Recipient.find(params[:recipient_id])
  @destination = [@recipient.address.to_s, @recipient.city.to_s].join(", ")
  @origin = params[:from_destination]
  
  render :action => 'map'# , :layout => false
end

  
end
