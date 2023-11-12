# typed: false
# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  extend T::Sig

  attribute :user, :account

  sig { params(user: User).returns(Account) }
  def user=(user)
    super
    self.account = user.account
  end
end
