# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe Repository do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:branch) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_inclusion_of(:status).in_array(RepositoryStateMachine.states) }

  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:access_token).optional }
  it { is_expected.to have_many(:commits).dependent(:destroy) }
end
