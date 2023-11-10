# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification::Delivery do
  it { is_expected.to belong_to(:notification) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:channel) }
  it { is_expected.to validate_inclusion_of(:channel).in_array(Notification::CHANNELS) }
end
