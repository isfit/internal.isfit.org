module InternalTabsHelper
  def tabs
    content_tag :ul, class: "nav" do
      unless logged_in?
        content_tag(:li,link_to('Log in', {} , {class: 'active'})).html_safe
      else
        InternalTab.arrange.map do |tab,children|
          url = url_for_arranged_tab(children)
          content_tag(:li ,link_to(tab.title.capitalize, url)) if url
        end.join.html_safe
      end
    end
  end

  def sublinks
    links = current_tab.new_record? ? [] : current_tab.descendants.arrange
    content_tag :ul, class: "nav nav-pills" do
      links.map do |sublink,children|
        if can_access_link? sublink
          url = url_for(controller: sublink.controller, action: sublink.action, id:sublink.action_id)
        else
          url = url_for_arranged_tab(children)
        end
        li_class = sublink == current_sublink ? "active" : ""
        content_tag(:li, link_to(sublink.title,url, class: li_class),class: li_class) if url
      end.join.html_safe
    end
  end

  def menu_groups
    menu_groups = current_sublink.new_record? ? [] : current_sublink.descendants.arrange
    menu_groups.map do |group, links|
      if url_for_arranged_tab(links)
        content_tag(:div, class: "well widget") do
          content_tag(:ul, class: "nav nav-list") do
            content_tag(:li, group.title, class: "nav-header") + 
              links.map do |menu_link,value|
                if can_access_link? menu_link
                  content_tag(:li, link_to(menu_link.title, url_for(controller: menu_link.controller, action: menu_link.action, id: menu_link.action_id)))
                end
              end.join.html_safe
          end
        end
      end
    end.join.html_safe
  end

  def nested_links(links)  
    links.map do |link, sub_links| 
      render(link) + content_tag(:div, nested_links(sub_links), :class => "nested_links")  
    end.join.html_safe  
  end  
end
