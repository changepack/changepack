# typed: false
# frozen_string_literal: true

class CommitDecorator < ApplicationDecorator
  Option = T.type_alias { T.any(T::Boolean, String) }
  Options = T.type_alias { T::Hash[Symbol, Option] }

  Element = T.type_alias { T.any(NilClass, String, Options) }
  Splat = T.type_alias { T::Array[Element] }

  sig { returns String }
  def abbr
    message.truncate(50)
  end

  sig { params(changelog: ChangelogDecorator).returns(Splat) }
  def checkbox_options(changelog)
    [].tap do |opts|
      true_value = id
      false_value = nil

      opts << checkbox_html_options(changelog)
      opts << true_value
      opts << false_value
    end
  end

  sig { params(changelog: ChangelogDecorator).returns(T::Boolean) }
  def checked?(changelog)
    changelog.id.present? && self.changelog == changelog
  end

  sig { params(changelog: ChangelogDecorator).returns(T::Boolean) }
  def disabled?(changelog)
    self.changelog.present? && self.changelog != changelog
  end

  private

  sig { params(changelog: ChangelogDecorator).returns(Options) }
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
