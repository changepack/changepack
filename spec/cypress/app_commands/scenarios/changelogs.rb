# typed: false
# frozen_string_literal: true

module Cypress
  class Changelogs
    extend FactoryBot::Syntax::Methods

    def self.seed
      create(:user, email: 'john.doe@example.com')
    end
  end
end

Cypress::Changelogs.seed
