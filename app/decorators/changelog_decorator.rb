# typed: false
# frozen_string_literal: true

class ChangelogDecorator < ApplicationDecorator
  def title_field_class
    h.text_field_class(self, :title)
  end

  def content_field_class
    "prose #{h.text_field_class(self, :content)}"
  end
end
