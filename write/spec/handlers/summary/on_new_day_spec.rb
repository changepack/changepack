require 'rails_helper'

describe Summary::OnNewDay do
  example 'sends a daily summary email' do
    allow(SummaryMailer).to receive(:notify)

    described_class.new.call

    expect(SummaryMailer).to have_enqueued_email(:notify)
  end
end

