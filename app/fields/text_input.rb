# typed: false
# frozen_string_literal: true

class TextInput < SimpleForm::Inputs::TextInput
  def input_html_classes
    super.push('prose')
  end
end
