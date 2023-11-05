# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe User do
  it { is_expected.to belong_to(:account).optional }
  it { is_expected.to have_many(:posts).dependent(:nullify) }
  it { is_expected.to have_many(:access_tokens).dependent(:destroy) }
end
