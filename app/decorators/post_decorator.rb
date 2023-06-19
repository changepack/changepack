# typed: false
# frozen_string_literal: true

class PostDecorator < ApplicationDecorator
  sig { returns String }
  def title_field_class
    h.text_field_class(self, :title)
  end

  sig { returns String }
  def content_field_class
    "prose text #{h.text_field_class(self, :content)}"
  end
end
