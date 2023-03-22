# typed: false
# frozen_string_literal: true

class CommitDecorator < ApplicationDecorator
  Element = T.type_alias { T.any(NilClass, String, CommitDecorator.to_options_shape) }
  Splat = T.type_alias { T::Array[Element] }

  sig { returns T::Shape }
  def self.to_options_shape
    {
      multiple: T::Boolean,
      id: T.nilable(String),
      class: String,
      checked: T::Boolean,
      disabled: T::Boolean
    }
  end

  sig { returns String }
  def abbr
    message.truncate(50)
  end

  sig { params(post: PostDecorator).returns(Splat) }
  def checkbox_options(post)
    [].tap do |opts|
      true_value = id
      false_value = nil

      opts << checkbox_html_options(post)
      opts << true_value
      opts << false_value
    end
  end

  sig { params(post: PostDecorator).returns(T::Boolean) }
  def checked?(post)
    post.persisted? && self.post == post
  end

  sig { params(post: PostDecorator).returns(T::Boolean) }
  def disabled?(post)
    self.post.present? && self.post != post
  end

  private

  sig { params(post: PostDecorator).returns(CommitDecorator.to_options_shape) }
  def checkbox_html_options(post)
    {
      multiple: true,
      id:,
      class: 'checkbox',
      checked: checked?(post),
      disabled: disabled?(post)
    }
  end
end
