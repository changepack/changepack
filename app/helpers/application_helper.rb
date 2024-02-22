# typed: false
# frozen_string_literal: true

module ApplicationHelper
  extend T::Sig

  include Pagy::Frontend

  sig { returns T.nilable(Symbol) }
  def current_controller
    params.fetch(:controller, nil)&.to_sym
  end

  def current_action
    params.fetch(:action, nil)&.to_sym
  end

  sig { params(name: T::Key, args: T.untyped).returns(T.untyped) }
  def icon(name, **args)
    fa_icon(name, **args)
  end

  sig { params(model: ApplicationRecord, field: T::Key).returns(String) }
  def text_field_class(model, field)
    "input string #{'input-invalid' if model.errors.include?(field.to_sym)}"
  end

  sig { params(account: Account).returns(T.untyped) }
  def brand(account)
    render 'accounts/brand', account:
  end
end
