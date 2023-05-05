# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Source
  describe Forbid do
    describe '#forbid_defaults!' do
      let!(:source) { create(:source) }

      it 'associates the forbidden keywords with the source' do
        Forbidden.defaults.each do |forbidden|
          expect(
            Forbidden.find_by(source:, type: forbidden.type, content: forbidden.content)
          ).to be_present
        end
      end
    end
  end
end
