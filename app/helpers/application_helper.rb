# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

 def tab_for(text, link)
    content_tag(:li, link_to(text, link), :class => ("active" if @current_section.titleize == text))
  end
  
 def this_saturday
    d = Date.today
    while d.cwday !=  6 do #6 = saturday
      d += 1
    end
    d
 end
 
  
end
