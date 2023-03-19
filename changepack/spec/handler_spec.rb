# typed: false
# frozen_string_literal: true

require 'rails_helper'

class TestEvent < Event
  attribute :foo, String
end

module Changepack
  describe Handler do
    let(:payload) do
      {
        event_type: 'TestEvent',
        data: { foo: 'bar' }
      }
    end

    let(:handler) do
      Class.new(described_class) do
        def run
          event.foo
        end
      end
    end

    subject { handler.new.perform(payload) }

    it { is_expected.to eq 'bar' }
  end
end
