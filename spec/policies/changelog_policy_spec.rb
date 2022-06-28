# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChangelogPolicy, type: :policy do
  let(:user) { build(:user, account:) }
  let(:account) { build(:account) }
  let(:record) { build(:changelog, user:, account:) }

  let(:context) { { user: } }

  let(:policy) { described_class.new(record, **context) }

  describe 'with a scope for params' do
    subject do
      ActionController::Parameters
        .new(title: 'Title', content: 'Content', published: true, commit_ids: [1, 2, 3], unpermitted: 'unpermitted')
        .then { |target| policy.apply_scope(target, type: :action_controller_params).to_h.symbolize_keys }
    end

    it { is_expected.to eq({ title: 'Title', content: 'Content', published: true, commit_ids: [1, 2, 3] }) }
  end

  describe_rule :show? do
    succeed 'with a user'
    succeed 'without a user' do
      let(:user) { nil }
    end
  end

  describe_rule :create? do
    succeed 'with a user'
    failed 'without a user' do
      let(:user) { nil }
    end
  end

  describe_rule :update? do
    before { account.send(:set_pretty_id) }

    succeed 'with the author'

    failed 'with a user from a different account' do
      let(:user) { build(:user).tap { |user| user.account.send(:set_pretty_id) } }
    end

    failed 'without any user' do
      let(:user) { nil }
    end
  end

  describe '#index?' do
    subject { :index? }

    it { is_expected.to be_an_alias_of(policy, :show?) }
  end

  describe '#new?' do
    subject { :new? }

    it { is_expected.to be_an_alias_of(policy, :create?) }
  end

  describe '#edit?' do
    subject { :edit? }

    it { is_expected.to be_an_alias_of(policy, :update?) }
  end

  describe '#confirm_destroy?' do
    subject { :confirm_destroy? }

    it { is_expected.to be_an_alias_of(policy, :update?) }
  end

  describe '#destroy?' do
    subject { :destroy? }

    it { is_expected.to be_an_alias_of(policy, :update?) }
  end
end
