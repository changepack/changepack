# typed: false
# frozen_string_literal: true

module Cypress
  class Posts
    extend FactoryBot::Syntax::Methods

    def self.seed
      user = create(:user, email: 'john.doe@example.com')
      create(:post, title: 'A post from another account')
      create(:update, id: 'upd_test', account: user.account)
    end
  end
end

Cypress::Posts.seed
