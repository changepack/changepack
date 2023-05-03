# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Issue do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:assignee) }

  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:team) }
end
