# typed: false
# frozen_string_literal: true

module API
  # Use `T.any` if more bearers are needed
  Bearer = T.type_alias { ::Account }
end
