# typed: false
# frozen_string_literal: true

require 'rails_helper'

describe Inquirer do
  subject { model.new(status:).status.foo? }

  let(:status) { 'foo' }
  let(:model) do
    Class.new do
      include ActiveModel::Model
      include ActiveModel::Attributes
      include Inquirer

      attribute :status, :string
      inquirer :status
    end
  end

  it { is_expected.to be true }

  context 'when value is nil' do
    let(:status) { nil }

    it { is_expected.to be false }
  end

  context 'when value is different' do
    let(:status) { 'bar' }

    it { is_expected.to be false }
  end
end
