# app/inputs/custom_content_input.rb
class CustomContentInput < SimpleForm::Inputs::Base
  disable :hint

  # You have to pass the content by capturing it as a block into a var, then pass it to the +content+ option
  # It's because simple_form automatically switch to BlockInput when you give a block, there is no way to override it
  def input
    # label code from https://github.com/plataformatec/simple_form/blob/master/lib/simple_form/components/labels.rb#28
    template.content_tag(:p, input_options.delete(:content), class: "form-control-static")
  end

  def additional_classes
    @additional_classes ||= [input_type].compact # original is `[input_type, required_class, readonly_class, disabled_class].compact`
  end
end