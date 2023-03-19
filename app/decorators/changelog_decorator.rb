# typed: false
# frozen_string_literal: true

class ChangelogDecorator < ApplicationDecorator
  sig { returns(T::String) }
  def title_field_class
    h.text_field_class(self, :title)
  end

  sig { returns(T::String) }
  def content_field_class
    "prose #{h.text_field_class(self, :content)}"
  end
end
