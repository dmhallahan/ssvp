
pdf.text "SSVP Food Deliveries for #{@current_delivery_date.strftime('%A %B %d %Y')} - Delivery Report", :size => 12
pdf.move_down(20)  


for delivery in @report
  vins = []
  delivery[0][0].each do |vin|
    vins << vin.vincentian.full_name.to_s unless vin.vincentian.blank?
  end
  pdf.text vins.join(", "), :size => 14, :style => :bold
  pdf.move_down(10)   
  
  delivery[0][1].each do |deliveries|
    r = deliveries.delivery.recipient
    info = []
    info[0] = r.address unless r.address.blank?
    info[1] =  "Apt: #{r.apt}" unless r.apt.blank?
    info[2] = r.phone_number unless r.phone_number.blank?
    info[3] = "Adults: #{r.adults}" unless r.adults.blank?
    info[4] = "Children: #{r.children}" unless r.children.blank?
    
    
    pdf.text r.full_name.to_s, :style => :bold
    pdf.text info.join("  ") 
    pdf.text "Notes: " + r.delivery_notes.to_s unless r.delivery_notes.blank?
    pdf.text "Bags: ________", :size => 12, :style => :bold
    pdf.move_down(10)   
  end

  pdf.move_down(20)
  
end


  

