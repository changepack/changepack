# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommitDecorator, type: :decorator do
  subject(:decorator) { described_class.new(commit) }

  def checkbox(checked:, disabled:)
    {
      multiple: true,
      id: commit.id,
      class: 'checkbox',
      checked:,
      disabled:
    }
  end

  let(:commit) { build(:commit) }

  let(:disabled) do
    [
      checkbox(checked: false, disabled: true),
      commit.id,
      nil
    ]
  end

  let(:checked) do
    [
      checkbox(checked: true, disabled: false),
      commit.id,
      nil
    ]
  end

  it 'makes the commit message shorter' do
    expect(decorator.abbr).to eq(commit.message.truncate(50))
  end

  it 'disables checkboxes for commits with other posts assigned' do
    post1 = create(:post).decorate
    post2 = create(:post).decorate
    commit.post = post1

    expect(decorator.checkbox_options(post2)).to eq(disabled)
  end

  it 'checks checkboxes for commits assigned to the current post' do
    post = create(:post).decorate
    commit.post = post

    expect(decorator.checkbox_options(post)).to eq(checked)
  end
end
