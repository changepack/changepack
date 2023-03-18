# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe User do
  it { is_expected.to belong_to(:account) }
  it { is_expected.to have_many(:changelogs).dependent(:nullify) }
end
