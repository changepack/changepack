# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Changelog
  describe Publish do
    let!(:user) { create(:user) }
    let(:repository) { create(:repository, account: user.account) }
    let(:commit) { create(:commit, repository:, account: user.account) }
    let(:changelog) { create(:changelog, user:) }

    describe '#publish' do
      subject(:command) { changelog.publish(publishable) }
      let(:publishable) { true }

      it 'sets status to published' do
        expect { command }.to change(changelog, :status).from('draft').to('published')
      end

      context 'when reverting' do
        let(:publishable) { false }
        let(:changelog) { create(:changelog, user:).tap { |c| c.transition_to!(:published) } }

        it 'sets status back to draft' do
          expect { command }.to change(changelog, :status).from('published').to('draft')
        end
      end
    end

    describe '#attach' do
      subject(:command) { changelog.attach(commits) }
      let(:commits) { [commit.id] }

      it 'sets changelog on commits' do
        expect { command }.to change { commit.reload.changelog_id }.from(nil).to(changelog.id)
      end
    end

    describe '#detach' do
      subject(:command) { changelog.detach(except: commits) }
      let(:commits) { [] }

      before { commit.update!(changelog:) }

      it 'removes changelog from commits' do
        expect { command }.to change { commit.reload.changelog_id }.from(changelog.id).to(nil)
      end

      context 'when excepting commits' do
        let(:commits) { [commit.id] }

        it 'does not remove changelog from commits' do
          expect { command }.not_to change(commit, :changelog_id)
        end
      end
    end
  end
end
