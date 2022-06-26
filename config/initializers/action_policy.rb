module ActionPolicy
  module Draper
    def policy_for(record:, **opts)
      # From https://github.com/GoodMeasuresLLC/draper-cancancan/blob/master/lib/draper/cancancan.rb
      record = record.model while record.is_a?(::Draper::Decorator)
      super(record: record, **opts)
    end
  end
end
