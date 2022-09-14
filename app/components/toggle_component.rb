# frozen_string_literal: true

class ToggleComponent < ApplicationComponent
  option :id, Types::String, default: -> { 'toggle' }
  option :label, Types::String.optional
  option :name, Types::String.optional
  option :checked, Types::Bool.optional
end
