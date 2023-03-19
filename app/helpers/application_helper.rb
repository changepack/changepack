# typed: false
# frozen_string_literal: true

module ApplicationHelper
  extend T::Sig

  include Pagy::Frontend

  sig { returns T::Symbol.nilable }
  def current_controller
    params.fetch(:controller, nil).try(:to_sym)
  end

  sig { params(name: T::Symbol | T::String, args: T.untyped).returns(T.untyped) }
  def icon(name, **args)
    fa_icon(name, **args)
  end

  sig { params(model: ApplicationRecord, field: T::Symbol | T::String).returns(String) }
  def text_field_class(model, field)
    "input #{'input-invalid' if model.errors.include?(field.to_sym)}"
  end

  sig { params(account: Account).returns(T.untyped) }
  def brand(account)
    render 'accounts/brand', account:
  end
end
