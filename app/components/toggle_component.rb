# frozen_string_literal: true

class ToggleComponent < ViewComponent::Base
  def initialize(id: 'toggle', label: nil, name: nil, checked: nil)
    @label = label
    @id = id
    @name = name
    @checked = checked

    super
  end
end
