# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Post
  describe Publish do
    let!(:user) { create(:user) }
    let(:repository) { create(:repository, account: user.account) }
    let(:commit) { create(:commit, repository:, account: user.account) }
    let(:post) { create(:post, user:) }

    describe '#publish' do
      subject(:command) { post.publish(publishable) }
      let(:publishable) { true }

      it 'sets status to published' do
        expect { command }.to change(post, :status).from('draft').to('published')
      end

      context 'when reverting' do
        let(:publishable) { false }
        let(:post) { create(:post, user:).tap { |c| c.transition_to!(:published) } }

        it 'sets status back to draft' do
          expect { command }.to change(post, :status).from('published').to('draft')
        end
      end
    end

    describe '#attach' do
      subject(:command) { post.attach(commits) }
      let(:commits) { [commit.id] }

      it 'sets post on commits' do
        expect { command }.to change { commit.reload.post_id }.from(nil).to(post.id)
      end
    end

    describe '#detach' do
      subject(:command) { post.detach(except: commits) }
      let(:commits) { [] }

      before { commit.update!(post:) }

      it 'removes post from commits' do
        expect { command }.to change { commit.reload.post_id }.from(post.id).to(nil)
      end

      context 'when excepting commits' do
        let(:commits) { [commit.id] }

        it 'does not remove post from commits' do
          expect { command }.not_to change(commit, :post_id)
        end
      end
    end
  end
end
