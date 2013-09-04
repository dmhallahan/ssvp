pdf.text "SSVP Food Deliveries", :size => 12
pdf.move_down(10)  

pdf.text "Central Report", :size => 12, :style => :bold  
from = @report.first.first.strftime("%B %e, %Y")
to = @report.last.first.strftime("%B %e, %Y")
pdf.text "For " + from.to_s + " to " + to.to_s

pdf.move_down(10) 

pdf.text "Total deliveries: " + @report.length.to_s

pdf.move_down(5)

pdf.table @report, 
    :border_style => :grid,  
    :font_size => 10,
    :row_colors => ["FFFFFF", "DDDDDD"],  
    :headers => ["Del. Date","Name", "Phone", "Address", "Apt", "Adlt", "Chld", "Vincentians", "Bags", "Comment"],  
    :column_widths => {0 => 80, 1 => 100, 2 => 80, 3 => 110, 4 => 40, 5 => 30, 6 => 32, 7 => 100, 8 => 40, 9 => 130 }