# frozen_string_literal: true

require 'rails_helper'

module Changelogs
  describe Upsert do
    let!(:user) { create(:user) }

    describe '#perform' do
      subject(:operation) { described_class.new(params) }

      let(:changelog) { build(:changelog, user:) }
      let(:title) { 'Title' }
      let(:content) { 'Content' }
      let(:published) { 'on' }

      def params
        {
          changelog:,
          user:,
          title:,
          content:,
          published:
        }
      end

      context 'when inserting' do
        it 'creates a changelog' do
          expect { operation.perform }.to change(Changelog, :count).by(1)
        end

        it 'sets status to published' do
          expect { operation.perform }.to change(changelog, :status).from('draft').to('published')
        end
      end

      context 'when updating' do
        let(:changelog) { create(:changelog, user:) }
        let(:title) { 'Updated title' }
        let(:published) { nil }

        before { changelog.transition_to!(:published) }

        it 'assigns new attributes to a changelog' do
          expect { operation.perform }.to change(changelog, :title).to('Updated title')
        end

        it 'sets status back to draft' do
          expect { operation.perform }.to change(changelog, :status).from('published').to('draft')
        end
      end
    end
  end
end
