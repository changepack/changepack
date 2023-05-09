# typed: false
# frozen_string_literal: true

require 'rails_helper'

module Test
  class Event < ::Event
    attribute :foo, String
  end

  class Handler < ::Handler
    def run
      raise event.foo
    end
  end
end

module Changepack
  describe Handler do
    let(:payload) do
      {
        event_type: Test::Event.name,
        data: { foo: 'bar' }
      }
    end

    subject(:handler) { Test::Handler.new }

    it 'runs the handler' do
      expect { handler.perform(payload) }.to raise_error('bar')
    end
  end
end
