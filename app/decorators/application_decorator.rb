# typed: false
# frozen_string_literal: true

class ApplicationDecorator < Draper::Decorator
  extend T::Sig

  delegate_all
end
