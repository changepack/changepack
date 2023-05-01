# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe Post do
  it { is_expected.to validate_length_of(:title).is_at_most(140) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_inclusion_of(:status).in_array(PostStateMachine.states) }

  it { is_expected.to have_many(:updates).dependent(:nullify) }
  it { is_expected.to belong_to(:user).optional }
  it { is_expected.to belong_to(:changelog) }
  it { is_expected.to belong_to(:account) }
end
