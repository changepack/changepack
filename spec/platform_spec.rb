# typed: false
# frozen_string_literal: true

require 'rails_helper'

path = Rails.root.join('platform/spec')
Dir.glob("#{path}/**/*_spec.rb") do |file|
  require file
end
