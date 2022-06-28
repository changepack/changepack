# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Commit::Author, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
end
