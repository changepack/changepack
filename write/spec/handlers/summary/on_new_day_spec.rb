require 'rails_helper'
require 'write/lib/summary/on_new_day'

describe Summary::OnNewDay do
  subject { described_class.new }
  
  let(:account) { create(:account) }
  
  context "on the first day of the month" do
    around do |example| 
      Timecop.freeze(Date.today.beginning_of_month) { example.run } 
    end
    
    expect { subject.call }.to have_enqueued_email(SummaryMailer, :notify)
  end
end
