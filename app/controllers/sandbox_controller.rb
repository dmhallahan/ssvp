class SandboxController < ApplicationController
  #require 'Prawn'
  
def test
  respond_to do |format|
    format.pdf
  end
end

def test_report
    @report = Delivery.team_report  
    respond_to do |format|
      format.xml  { render :xml => @report }
    end
    
  end

end
