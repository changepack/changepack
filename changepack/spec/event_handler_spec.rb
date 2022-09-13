# frozen_string_literal: true

require 'rails_helper'

module Changepack
  describe EventHandler do
    let(:payload) do
      {
        event_type: 'Event',
        data: { foo: 'bar' }
      }
    end

    let(:handler) do
      Class.new(described_class) do
        def call
          event.data.foo
        end
      end
    end

    subject { handler.new.perform(payload) }

    it { is_expected.to eq 'bar' }
  end
end
