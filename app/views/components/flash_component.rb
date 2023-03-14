# frozen_string_literal: true

class FlashComponent < ApplicationComponent
  attribute :type, Types::Coercible::String.default('alert').enum('notice', 'alert', 'info')

  def template(&)
    div do
      div class: "py-2 px-3 mb-10 font-medium rounded-lg inline-block #{color}", &
    end
  end

  def color
    {
      notice: 'bg-green-50 text-green-500',
      alert: 'bg-yellow-50 text-yellow-500',
      info: 'bg-gray-50 text-gray-500'
    }.fetch(type.to_sym)
  end
end
