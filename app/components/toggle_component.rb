# frozen_string_literal: true

class ToggleComponent < ApplicationComponent
  option :id, default: -> { 'toggle' }
  option :label, optional: true
  option :name, optional: true
  option :checked, optional: true
end
