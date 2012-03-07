#Inspired from railscasts episode 311
class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  delegate :capture, :content_tag, :tag, to: :@template
  %w[text_field file_field text_area password_field check_box number_field collection_select select].each do |method_name|
    define_method(method_name) do |name, *args|
      content_tag :div, class: "field" do
        field_label(name, *args) + super(name, *args) + defined_hint(*args)
      end
    end
  end

  def datetime_select(name, *args)
    options = args.extract_options!
    options[:class] = "" if options[:class].nil?
    options[:class] += " datetimepicker span3"
    text_field(name, options)
  end

  def submit(*args)
    content_tag :div, class: "field" do
      super(class: 'btn-primary')
    end
  end

  def error_messages
    if object.errors.full_messages.any?
      content_tag(:div, class: "alert-message block-message error", "data-alert" => "true") do
        content_tag(:a, "x", href: "#",class: "close") +
        content_tag(:h2, "Invalid Fields") +
          content_tag(:ul) do
          object.errors.full_messages.map do |msg|
            content_tag(:li, msg)
          end.join.html_safe
          end
      end
    end
  end

  def fieldset(name, &block)
    data = block_given? ? capture(&block) : ''
    content_tag :fieldset do
      content_tag(:legend, name) + data
    end
  end

private

  def defined_hint(*args)
    options = args.extract_options!
    if options["hint-title"].nil? || options["hint-content"].nil?
      ''
    else 
      content_tag :p, class: "btn", rel: "popover", "data-original-title" => options["hint-title"], "data-content" => options["hint-content"] do
        "What is this?"
      end
    end
  end
  def field_label(name, *args)
    options = args.extract_options!
    required = object.class.validators_on(name).any? { |v| v.kind_of? ActiveModel::Validations::PresenceValidator }
    label(name, options[:label], class: ("required" if required))
  end

  def objectify_options(options)
    super.except(:label)
  end
end
