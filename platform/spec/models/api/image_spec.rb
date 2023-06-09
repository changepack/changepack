# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::Image, :vcr do
  let(:image) { build(:api_image) }

  it 'has a valid factory' do
    expect(image).to be_valid
  end

  it 'has an attached file' do
    expect(image.file).to be_attached
  end
end
