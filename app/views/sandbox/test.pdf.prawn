  pdf.bounding_box [100,600], :width => 200 do
    pdf.text "The rain in spain falls mainly on the plains " * 5
    pdf.stroke do
      pdf.line pdf.bounds.top_left,    pdf.bounds.top_right
      pdf.line pdf.bounds.bottom_left, pdf.bounds.bottom_right
    end
  end

  pdf.bounding_box [100,500], :width => 200, :height => 200 do
    pdf.stroke do
      pdf.circle_at [100,100], :radius => 100
      pdf.line pdf.bounds.top_left, pdf.bounds.bottom_right
      pdf.line pdf.bounds.top_right, pdf.bounds.bottom_left
    end   

    pdf.bounding_box [50,150], :width => 100, :height => 100 do
      pdf.stroke_rectangle pdf.bounds.top_left, pdf.bounds.width, pdf.bounds.height
    end   
  end

