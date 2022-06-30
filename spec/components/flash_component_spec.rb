# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FlashComponent, type: :component do
  it 'renders a notice' do
    render_inline(described_class.new(type: 'notice')) { 'Notice' }

    expect(page).to have_text 'Notice'
  end

  it 'renders an alert' do
    render_inline(described_class.new(type: 'alert')) { 'Alert' }

    expect(page).to have_text 'Alert'
  end

  it 'renders information' do
    render_inline(described_class.new(type: 'info')) { 'Information' }

    expect(page).to have_text 'Information'
  end
end
