module ApplicationHelper

  def transliterate(str)
    # Based on permalink_fu by Rick Olsen

    # Downcase string
    s.downcase!

    # Remove apostrophes so isn't changes to isnt
    s.gsub!(/'/, '')

    # Replace any non-letter or non-number character with a space
    s.gsub!(/[^A-Za-z0-9]+/, ' ')

    # Remove spaces from beginning and end of string
    s.strip!

    # Replace groups of spaces with single hyphen
    s.gsub!(/\ +/, '-')

    return s
  end

  def url_for_internal_tab(tab)
    logger.info tab.inspect if !can_access_link(tab)
    return root_url if !can_access_link(tab)
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
    logger.info "can? #{link.inspect}"
    return false unless current_user
    if link.controller && link.action
      logger.info "canCheck? #{can?(link.action, link.controller)}"
      return can?(link.action, link.controller)
    elsif link.children.size == 0
      return false
    else
      link.children.each do |child|
        return can_access_link(child)
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
