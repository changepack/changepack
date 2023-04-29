# typed: false
# frozen_string_literal: true

class AccountPicturePreview < Lookbook::Preview
  def default
    render I::AccountPicture.new(account: Account.new)
  end
end
