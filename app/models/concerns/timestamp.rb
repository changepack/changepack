# frozen_string_literal: true

module Timestamp
  extend ActiveSupport::Concern

  def created = created_at
  def updated = updated_at
end
