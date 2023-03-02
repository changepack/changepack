# frozen_string_literal: true

class ToggleComponent < ApplicationComponent
  attribute :name, Types::String.optional
  attribute :label_value, Types::String.optional
  attribute :checked, Types::Bool.optional
  attribute :id, Types::String, default: -> { 'toggle' }

  def template
    toggle
    label_tag
  end

  def toggle
    div(**wrapper_classes) do
      input(
        class: toggle_class,
        type: 'checkbox',
        name:,
        id:,
        checked:
      )
      label class: 'toggle-label block overflow-hidden h-6 rounded-full bg-gray-200 cursor-pointer', for: id
    end
  end

  def wrapper_classes
    classes('relative inline-block w-10 align-middle select-none transition duration-200 ease-in', label?: 'mr-2')
  end

  def toggle_class
    %(
      toggle-checkbox absolute block w-6 h-6 rounded-full bg-white border-4
      border-gray-200 appearance-none cursor-pointer
    )
  end

  def label? = label_value.present?

  def label_tag
    label for: id, data: { test_id: 'toggle' } do
      text label_value
    end
  end
end
