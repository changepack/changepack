# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Update
  describe Forbid do
    let(:update) { build(:update, email: '49699333+dependabot[bot]@users.noreply.github.com') }

    before { update.save }

    it 'blocks dependabot based on default forbidden keywords' do
      expect(update.errors.to_a).to eq ['Email matches a forbidden keyword']
    end
  end
end
