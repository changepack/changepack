# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Source
  describe Ban do
    describe '#ban_defaults!' do
      let!(:source) { create(:source, :repository) }

      it 'associates the banned keywords with the source' do
        Banned.defaults.each do |banned|
          expect(
            Banned.find_by(source:, type: banned.type, content: banned.content)
          ).to be_present
        end
      end
    end
  end
end
