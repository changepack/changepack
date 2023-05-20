# typed: false
# frozen_string_literal: true

module ApplicationHelper
  extend T::Sig

  include Pagy::Frontend

  sig { returns T.nilable(Symbol) }
  def current_controller
    params.fetch(:controller, nil).try(:to_sym)
  end

  sig { params(name: T::Key, args: T.untyped).returns(T.untyped) }
  def icon(name, **args)
    fa_icon(name, **args)
  end

  sig { params(model: ApplicationRecord, field: T::Key).returns(String) }
  def text_field_class(model, field)
    "input #{'input-invalid' if model.errors.include?(field.to_sym)}"
  end

  sig { params(account: Account).returns(T.untyped) }
  def brand(account)
    render 'accounts/brand', account:
  end

  def scoped_post_path(post)
    if request.subdomain.present?
      domain_post_path(post)
    else
      account_post_path(post.account, post)
    end
  end

  def scoped_post_url(post)
    if request.subdomain.present?
      domain_post_url(post)
    else
      account_post_url(post.account, post)
    end
  end
end
