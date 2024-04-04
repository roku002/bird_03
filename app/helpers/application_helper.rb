module ApplicationHelper
  def page_title(title)
    base_title = 'BIRD APP' 

    title.empty? ? base_title : title + " | " +  base_title
  end
end
