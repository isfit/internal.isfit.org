module InternalTabsHelper
  def nested_links(links)  
    links.map do |link, sub_links| 
      render(link) + content_tag(:div, nested_links(sub_links), :class => "nested_links")  
    end.join.html_safe  
  end  
end
