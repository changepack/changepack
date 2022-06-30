# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to belong_to(:account) }
  it { is_expected.to have_many(:changelogs).dependent(:nullify) }
  it { is_expected.to have_many(:repositories).dependent(:delete_all) }
end
