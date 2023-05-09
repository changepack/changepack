# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Source
  describe OnRepositoryDestroyed do
    let(:repository) { create(:repository) }
    let!(:source) { create(:source, :repository, repository:) }
    let(:payload) do
      {
        event_type: 'Repository::Destroyed',
        data: Repository::Resource.to_event(repository)
      }
    end

    subject(:handler) { described_class.new }

    it 'destroys the source' do
      handler.perform(payload)

      expect(Source.find_by(id: source.id)).to be_nil
    end
  end
end
