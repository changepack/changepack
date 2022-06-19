# frozen_string_literal: true

module Changepack
  module Timestamp
    extend ActiveSupport::Concern

    def created = created_at
    def updated = updated_at
  end
end
