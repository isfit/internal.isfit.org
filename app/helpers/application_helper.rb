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

  # Traverses a given tab for each of its children
  # Works recursive, and traveres the tree-structure of the internal menu system. 
  # Also check for access before returning the url
  #
  # @param [Hash] a hash with keys as InternalTab and values as a hash of nested InternalTab
  # @return [String] returns the first recognized url for the given
  #
  # @example url_for_arranged_tab(InternalTab.arrange) will return the first accessable link for the root-tabs

  def url_for_arranged_tab(tab)
    current = tab.keys
    children = tab.values
    return false if current.empty?

    current.each do |c|
      if c.controller && c.action
        if can?(c.action.to_sym, Kernel.const_get(c.controller.classify))
          return url_for(controller: c.controller, action: c.action, id:c.action_id)
        end
      end
    end
    
    children.each do |child|
      url = url_for_arranged_tab(child)
      return url if url
    end
    #a_hash = {}.tap{ |r| children.values.each{ |h| h.each{ |k,v| (r[k]||=[]) << v } } }
    #return url_for_arranged_tab(child)
    return false
  end

  def numeric?(object)
    true if Float(object) rescue false
  end

  # Check if current_user can access link
  #
  # @param [InternalTab] A link to check
  # @return [true|false] depending on access
    
  def can_access_link?(link)
    if link.controller && link.action
      return can?(link.action.to_sym, Kernel.const_get(link.controller.classify))
    else 
      return false
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

  def format(text)
    sanitize(markdown(text))
  end
  
  def markdown(text)
    BlueCloth::new(text).to_html
  end
end
