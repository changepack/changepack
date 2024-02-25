# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Hook
  describe OnPostPublished do
    let(:post) { create(:post) }
    let(:payload) do
      {
        event_type: 'Post::Published',
        data: { id: post.id, content: post.content.to_s, account_id: }
      }
    end

    subject(:handler) { described_class.new }

    before { create(:template, category: :write, type: :summary) }

    context 'when account is present' do
      let(:account_id) { post.account_id }

      it 'creates a notification' do
        expect { handler.perform(payload) }.to change(Notification, :count).by(1)
      end
    end

    context 'when account is blank' do
      let(:account_id) { nil }

      it 'does not create a notification' do
        expect { handler.perform(payload) }.not_to(change(Notification, :count))
      end
    end
  end
end
