# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repository, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:branch) }
  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_inclusion_of(:provider).in_array(Provider.types) }
  it { is_expected.to validate_presence_of(:provider_id) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_inclusion_of(:status).in_array(RepositoryStateMachine.states) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:account) }
end
