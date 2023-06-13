require 'rails_helper'

RSpec.describe Summary::OnRequested, :vcr do
  describe '#run' do
    subject(:handler) { described_class.new }

    context 'on the first day of the month' do
      before do
        travel_to(Date.new(2020, 1, 1)) do
          handler.run
        end
      end

      it 'enqueues an email' do
        expect(SummaryMailer).to have_enqueued_email(:notify)
      end
    end
  end
end

