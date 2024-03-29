# typed: false
# frozen_string_literal: true

require 'rails_helper'

class Issue
  describe Assignee do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end
end
