# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe SourcePolicy, type: :policy do
  let(:user) { build(:user, account:) }
  let(:account) { build(:account) }
  let(:record) { build(:source, :repository, account:) }

  let(:context) { { user: } }

  let(:policy) { described_class.new(record, **context) }

  describe 'with a relation scope' do
    subject do
      Source
        .all
        .then { |target| policy.apply_scope(target, type: :active_record_relation).pluck(:name) }
    end

    before do
      record.update!(name: 'A')
      create(:source, :repository, name: 'B')
    end

    it { is_expected.to eq %w[A] }
  end

  describe_rule :create? do
    succeed
  end

  describe_rule :update? do
    before { account.send(:set_pretty_id) }

    succeed 'with the owner'

    failed 'with a user from a different account' do
      let(:user) { build(:user).tap { |user| user.account.send(:set_pretty_id) } }
    end
  end

  describe '#index?' do
    subject { :index? }

    it { is_expected.to be_an_alias_of(policy, :create?) }
  end

  describe '#new?' do
    subject { :new? }

    it { is_expected.to be_an_alias_of(policy, :create?) }
  end

  describe '#show?' do
    subject { :show? }

    it { is_expected.to be_an_alias_of(policy, :update?) }
  end

  describe '#edit?' do
    subject { :edit? }

    it { is_expected.to be_an_alias_of(policy, :update?) }
  end

  describe '#destroy?' do
    subject { :destroy? }

    it { is_expected.to be_an_alias_of(policy, :update?) }
  end
end
