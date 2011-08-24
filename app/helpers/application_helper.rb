module ApplicationHelper
  def url_for_internal_tab(tab)
    if tab.controller && tab.action
      url_for(controller: tab.controller, action: tab.action, id:tab.action_id)
    elsif tab.children.size == 0
      root_url
    else
      url_for_internal_tab(tab.children.first)
    end
  end

  def numeric?(object)
    true if Float(object) rescue false
  end

  def can_access_link(link)
    return false unless current_user
    if link.controller && link.action
      return can?(link.action, link.controller)
    elsif link.children.size == 0
      return false
    else
      link.children.each do |child|
        return true if can_access_link(child)
      end
    end
  end


  def sortable(column, parameters, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    parameters[:sort] = column
    parameters[:direction] = direction
    link_to title, parameters, {:class => css_class}
  end

end
