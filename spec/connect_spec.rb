# typed: false
# frozen_string_literal: true

require 'rails_helper'

path = Rails.root.join('connect/spec')
Dir.glob("#{path}/**/*_spec.rb") { |file| require file }
