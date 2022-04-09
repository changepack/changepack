# frozen_string_literal: true

module Cypress
  class Accounts
    extend FactoryBot::Syntax::Methods

    def self.seed
      account = create(:account).tap { |a| a.update!(id: 'acc_test') }
      user = create(:user, account:)
      create(:changelog, account:, user:, status: :published, title: 'Published').tap do |c|
        c.update!(id: 'log_published')
      end
      create(:changelog, account:, user:, status: :draft, title: 'Draft')
    end
  end
end

Cypress::Accounts.seed
