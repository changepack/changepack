# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification::Job, type: :job do
  describe '#perform' do
    let(:delivery_id) { SecureRandom.uuid }
    let(:delivery) { build(:delivery, id: delivery_id) }

    before do
      allow(Notification::Delivery).to receive(:find).with(delivery_id).and_return(delivery)
      allow(delivery).to receive(:save!).and_return(true)
    end

    context 'when channel is email' do
      let(:mailer) { instance_double(NotificationMailer) }
      let(:notification_mail) { instance_double(ActionMailer::MessageDelivery) }

      before do
        allow(NotificationMailer).to receive(:with).with(delivery:).and_return(mailer)
        allow(mailer).to receive(:notify).and_return(notification_mail)
        allow(notification_mail).to receive(:deliver_now)
      end

      it 'sends an email notification' do
        described_class.new.perform(delivery_id)
        expect(notification_mail).to have_received(:deliver_now)
      end
    end

    context 'when channel is slack' do
      let(:notifier) { instance_double(Slack::Notifier) }
      let(:delivery) { build(:delivery, :slack, id: delivery_id) }

      before do
        allow(Slack::Notifier).to receive(:new).and_return(notifier)
        allow(notifier).to receive(:ping)
      end

      it 'sends a slack notification' do
        described_class.new.perform(delivery_id)
        expect(notifier).to have_received(:ping)
      end
    end

    context 'when channel is unknown' do
      before { allow(delivery).to receive(:channel).and_return('unknown') }

      it 'raises an error' do
        expect { described_class.new.perform(delivery_id) }.to raise_error(RuntimeError, 'Unknown channel unknown')
      end
    end
  end
end
