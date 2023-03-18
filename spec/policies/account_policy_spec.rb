# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe AccountPolicy, type: :policy do
  let(:user) { build(:user, account: record) }
  let(:record) { build(:account) }

  let(:context) { { user: } }

  let(:policy) { described_class.new(record, **context) }

  describe_rule :index? do
    succeed 'with a user'
    failed 'without a user' do
      let(:user) { nil }
    end
  end
end
