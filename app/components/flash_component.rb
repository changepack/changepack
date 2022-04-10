# frozen_string_literal: true

class FlashComponent < ApplicationComponent
  option :type, type: Types::String.default('alert').enum('notice', 'alert')

  def call
    content_tag(:div) do
      content_tag(:p, class: "py-2 px-3 mb-10 font-medium rounded-lg inline-block #{color}") do
        content
      end
    end
  end

  private

  def color
    case type.to_sym
    when :notice
      'bg-green-50 text-green-500'
    when :alert
      'bg-yellow-50 text-yellow-500'
    end
  end

  def render?
    content.present?
  end
end
