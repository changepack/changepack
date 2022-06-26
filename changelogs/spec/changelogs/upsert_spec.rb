# frozen_string_literal: true

require 'rails_helper'

module Changelogs
  describe Upsert do
    let!(:user) { create(:user) }
    let(:repository) { create(:repository, account: user.account) }
    let(:commit) { create(:commit, repository:, account: user.account) }
    let(:changelog) { build(:changelog, user:) }

    describe '#execute' do
      subject(:command) { described_class.new(**params) }

      let(:params) do
        {
          user:,
          changelog:,
          title: 'Title',
          content: 'Content',
          published: 'on',
          commit_ids: [commit.id]
        }
      end

      context 'when inserting' do
        it 'creates a changelog' do
          expect { command.execute }.to change(Changelog, :count).by(1)
        end

        it 'sets status to published' do
          expect { command.execute }.to change(changelog, :status).from('draft').to('published')
        end

        it 'links the changelog to the commit' do
          expect { command.execute }.to change { commit.reload.changelog }.from(nil).to(changelog)
        end
      end

      context 'when updating' do
        subject(:command) do
          described_class.new(**params.merge(
            title: 'Updated title',
            published: nil
          ))
        end

        let(:changelog) { create(:changelog, user:).tap { |c| c.transition_to!(:published) } }

        it 'assigns new attributes to a changelog' do
          expect { command.execute }.to change(changelog, :title).to('Updated title')
        end

        it 'sets status back to draft' do
          expect { command.execute }.to change(changelog, :status).from('published').to('draft')
        end
      end
    end
  end
end
