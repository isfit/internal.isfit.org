module ApplicationHelper

  include FormattingHelper

  def bootstrap_form_for(object, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    options[:html] = {class: "form-stacked"}
    form_for(object, options, &block)
  end

  def transliterate(s)
    # Based on permalink_fu by Rick Olsen
    s = String.new(s)

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
      # url_for retains the namespace when creating new urls. So if current url is
      # /transport/drives, the url_for(controller: "frontend_articles", action: "index")
      # will be /transport/articles/
      # The rails official solution is to prepend a slash before the controller
      if can_access_link?(c)
        begin
          return url_for(controller: c.controller, action: c.action, id:c.action_id)
        rescue ActionController::UrlGenerationError
          return url_for(controller: "/#{c.controller}", action: c.action, id:c.action_id)
        end
      end
    end

    children.each do |child|
      url = url_for_arranged_tab(child)
      return url if url
    end
    return false
  end


  def numeric?(object)
    true if Float(object) rescue false
  end

  # Check if current_user can access link
  #
  # The rescue block is there for a reason, and shortly explained here:
  # The thought behind link.controller is that a controller has many actions that can be linked to. (if it is the best approach is an other discussion)
  # Anyway, CanCan accepts Model-classes as the 2. argument so the controller-name will be classified to the model behind the controller.
  # This means that a controller without a model will throw an exception here. This is "easy" bypassed with the rescue.
  # In CanCan 2.0 the behavior should be changed from Classes to symbols as the 2. argument, and it could be solved that way.
  # In the mean-time, all actions on a controller without a model would get true returned from this method
  # @param [InternalTab] A link to check
  # @return [true|false] depending on access

  def can_access_link?(link)
    access = can?(link.action.to_sym, Kernel.const_get(link.controller.classify)) rescue true
    link.controller && link.action && access
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



