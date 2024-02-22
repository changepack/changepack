# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification::Template do
  it { is_expected.to have_many(:notifications) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:summary) }
  it { is_expected.to validate_presence_of(:category) }

  it 'validates uniqueness of type scoped to category' do
    create(:template, type: :type1, category: :category1)
    expect { create(:template, type: :type1, category: :category1) }.to raise_error(ActiveRecord::RecordInvalid)
    create(:template, type: :type1, category: :category2)
  end
end
