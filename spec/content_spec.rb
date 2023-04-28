require "rails_helper"

path = Rails.root.join("content/spec")
Dir.glob("#{path}/**/*_spec.rb") { |file| require file }
