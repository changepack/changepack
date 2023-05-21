# typed: false
# frozen_string_literal: true

module T
  module API
    # Use `T.any` if more beaers are needed
    Bearer = T.type_alias { ::Account }
    Bearers = T.type_alias { ::Account::RelationType }
  end
end

module API
  def self.table_name_prefix
    'api_'
  end
end
