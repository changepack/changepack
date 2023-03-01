# frozen_string_literal: true

class ToggleComponent < LegacyApplicationComponent
  option :id, Types::String, default: -> { 'toggle' }
  option :label, Types::String.optional
  option :name, Types::String.optional
  option :checked, Types::Bool.optional
end
