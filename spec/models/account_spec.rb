# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'is created together with a user' do
    expect { create(:user) }.to change(described_class, :count).by(1)
  end
end
