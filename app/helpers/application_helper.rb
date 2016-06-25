module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == params[:sort] ? "current #{params[:direction]}" : nil
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
  
  def get_img(column, title = nil)
    title ||= column.titleize
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    if direction == "asc"
      link_to image_tag("down_arrow.gif"), {:sort => column, :direction => direction}
    else 
      link_to image_tag("up_arrow.gif"), {:sort => column, :direction => direction}
    end
  end
  
end
