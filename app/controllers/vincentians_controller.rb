class VincentiansController < ApplicationController
  
    before_filter :set_current_section
    
    def set_current_section
      @current_section = "vincentians"
    end

protect_from_forgery :except => [:post_data]

# Don't forget to edit routes if you're using RESTful routing (see config/routes.rb)
  def post_data
    
    # It's of course your role to add security / validation here
    
    if params[:oper] == "del"
      Vincentian.find(params[:id]).destroy
    else
      vincentian_params = { :first_name => params[:first_name],
                                    :last_name => params[:last_name], 
                                    :phone_number => params[:phone_number],
                                    :address => params[:address],                      
                                    :city => params[:city],
                                    :postal_code => params[:postal_code],
                                    :notes => params[:notes]
                                  }
                                  
      if params[:id] == "_empty"
        vincentian = Vincentian.create(vincentian_params)
      else
        vincentian = Vincentian.find(params[:id])
        vincentian.update_attributes(vincentian_params)
      end
    end
    
  # If you need to display error messages
    err = ""
    if vincentian
      vincentian.errors.entries.each do |error|
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

    # Queries are here for clarity purposes in this demo
    # It's of course a better idea to create a method in your model

    vincentians = Vincentian.find(:all) do
      if params[:_search] == "true"
        first_name =~ "%#{params[:first_name]}%" if params[:first_name].present?
        last_name =~ "%#{params[:last_name]}%" if params[:last_name].present?                
        phone_number =~ "%#{params[:phone_number]}%" if params[:phone_number].present?
        address =~ "%#{params[:address]}%" if params[:address].present?
        city =~ "%#{params[:city]}%" if params[:city].present?
        postal_code =~ "%#{params[:postal_code]}%" if params[:postal_code].present?
        notes =~ "%#{params[:notes]}%" if params[:notes].present?
      end
      paginate :page => params[:page], :per_page => params[:rows]      
      order_by "#{params[:sidx]} #{params[:sord]}"
    end
    if request.xhr?
      render :json => vincentians.to_jqgrid_json([:first_name,:last_name,:phone_number, :address, :city, :postal_code, :notes], params[:page], params[:rows], vincentians.total_entries) and return
    end
  end


end
