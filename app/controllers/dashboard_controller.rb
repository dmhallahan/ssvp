class DashboardController < ApplicationController
    before_filter :set_current_section
    
    def set_current_section
      @current_section = "dashboard"
    end

  def index
  end

end
