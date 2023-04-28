# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateDecorator, type: :decorator do
  subject(:decorator) { described_class.new(update) }

  def checkbox(checked:, disabled:)
    {
      multiple: true,
      id: update.id,
      class: 'checkbox',
      checked:,
      disabled:
    }
  end

  let(:update) { build(:update) }

  let(:disabled) do
    [
      checkbox(checked: false, disabled: true),
      update.id,
      nil
    ]
  end

  let(:checked) do
    [
      checkbox(checked: true, disabled: false),
      update.id,
      nil
    ]
  end

  it 'disables checkboxes for updates with other posts assigned' do
    post1 = create(:post).decorate
    post2 = create(:post).decorate
    update.post = post1

    expect(decorator.checkbox_options(post2)).to eq(disabled)
  end

  it 'checks checkboxes for updates assigned to the current post' do
    post = create(:post).decorate
    update.post = post

    expect(decorator.checkbox_options(post)).to eq(checked)
  end
end
