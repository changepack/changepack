# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Source
  describe OnRepositoryDestroyed do
    let(:user) { create(:user) }
    let(:repository) { create(:repository) }
    let(:source) { create(:source, repository:) }
    let(:payload) do
      {
        event_type: 'Repository::Destroyed',
        data: {
          id: source.repository_id
        }
      }
    end

    subject(:handler) { described_class.new }

    it 'destroys the source' do
      handler.perform(payload)

      expect(Source.find_by(id: source.id)).to be_nil
    end
  end
end
