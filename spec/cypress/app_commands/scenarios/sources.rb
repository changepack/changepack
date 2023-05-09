# typed: false
# frozen_string_literal: true

module Cypress
  class Sources
    extend FactoryBot::Syntax::Methods

    def self.seed
      user = create(:user, email: 'john.doe@example.com')
      repository = create(:repository, account: user.account)

      create(:access_token, account: user.account)
      create(:source, :repository, account: user.account, repository:)
    end
  end
end

Cypress::Sources.seed
