# frozen_string_literal: true

class ChangelogDecorator < ApplicationDecorator
  delegate_all

  def published_field_id
    ['toggle', id].compact.join('_')
  end

  def title_field_class
    h.text_field_class(self, :title)
  end

  def content_field_class
    "prose #{h.text_field_class(self, :content)}"
  end
end
