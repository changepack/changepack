# typed: false
# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  extend T::Sig

  retry_on ActiveRecord::Deadlocked
  discard_on ActiveJob::DeserializationError
end
