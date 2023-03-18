# typed: false
# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def current_controller
    params[:controller]&.to_sym
  end

  def icon(name, **args)
    fa_icon(name, **args)
  end

  def text_field_class(model, field)
    "input #{'input-invalid' if model.errors.include?(field.to_sym)}"
  end

  def brand(account)
    render 'accounts/brand', account:
  end
end
