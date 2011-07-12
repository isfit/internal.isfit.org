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
end
