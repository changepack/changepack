# frozen_string_literal: true

class CommitDecorator < ApplicationDecorator
  delegate_all

  def abbr
    message.truncate(50)
  end

  def checkbox_options(changelog)
    [].tap do |opts|
      true_value = id
      false_value = nil

      opts << checkbox_html_options(changelog)
      opts << true_value
      opts << false_value
    end
  end

  def checked?(changelog)
    changelog.id && self.changelog == changelog
  end

  def disabled?(changelog)
    self.changelog && self.changelog != changelog
  end

  private

  def checkbox_html_options(changelog)
    {
      multiple: true,
      id:,
      class: 'checkbox',
      checked: checked?(changelog),
      disabled: disabled?(changelog)
    }
  end
end
