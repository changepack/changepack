# frozen_string_literal: true

class ToggleComponent < ApplicationComponent
  option :id, type: Types::String, default: -> { 'toggle' }
  option :label, type: Types::String, optional: true
  option :name, type: Types::String, optional: true
  option :checked, type: Types::Bool, optional: true
end
