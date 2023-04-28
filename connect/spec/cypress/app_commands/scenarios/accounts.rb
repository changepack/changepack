# typed: false
# frozen_string_literal: true

module Cypress
  class Accounts
    extend FactoryBot::Syntax::Methods

    def self.seed
      account = create(:account, slug: 'acc_test')
      user = create(:user, account:)
      create(:post, account:, user:, status: :published, title: 'Published', slug: 'log_published')
      create(:post, account:, user:, status: :draft, title: 'Draft')
    end
  end
end

Cypress::Accounts.seed
