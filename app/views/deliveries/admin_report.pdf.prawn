pdf.text "SSVP Food Deliveries", :size => 12
pdf.text "Admin Report", :size => 12
pdf.move_down(10)  

pdf.text "Deliveries for #{@current_delivery_date.strftime('%A %B %d %Y')}", :size => 12, :style => :bold  

pdf.move_down(10) 

pdf.table @report, 
  :font_size => 16,
  :border_style => :grid,  
  :row_colors => ["FFFFFF", "DDDDDD"],  
  :width => 500,
  :headers => ["Vincentians","Recipient", "Bags"]
  
