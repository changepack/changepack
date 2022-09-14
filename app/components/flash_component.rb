# frozen_string_literal: true

class FlashComponent < ApplicationComponent
  option :type, Types::Coercible::String.default('alert').enum('notice', 'alert', 'info')

  def call
    content_tag(:div) do
      content_tag(:p, class: "py-2 px-3 mb-10 font-medium rounded-lg inline-block #{color}") do
        content
      end
    end
  end

  private

  def color
    {
      notice: 'bg-green-50 text-green-500',
      alert: 'bg-yellow-50 text-yellow-500',
      info: 'bg-gray-50 text-gray-500'
    }.fetch(type.to_sym)
  end

  def render?
    content.present?
  end
end
