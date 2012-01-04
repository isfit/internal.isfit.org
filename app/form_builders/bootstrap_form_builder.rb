#Inspired from railscasts episode 311
class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  delegate :capture, :content_tag, :tag, to: :@template
  %w[text_field text_area password_field check_box number_field collection_select].each do |method_name|
    define_method(method_name) do |name, *args|
      content_tag :div, class: "field" do
        field_label(name) + super(name, *args) + defined_hint(*args)
      end
    end
  end

  def submit(*args)
    content_tag :div, class: "field" do
      super
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
