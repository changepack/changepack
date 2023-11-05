# typed: false
# frozen_string_literal: true

module RoutesHelper
  extend T::Sig

  sig { params(post: Post).returns(String) }
  def scoped_post_path(post)
    if request.subdomain.present?
      domain_post_path(post)
    else
      account_post_path(post.account, post)
    end
  end

  sig { params(post: Post).returns(String) }
  def scoped_post_url(post)
    if request.subdomain.present?
      domain_post_url(post)
    else
      account_post_url(post.account, post)
    end
  end

  sig { params(newsletter: Newsletter).returns(String) }
  def scoped_newsletter_path(newsletter)
    if request.subdomain.present?
      domain_newsletter_path(newsletter)
    else
      account_newsletter_path(newsletter.account, newsletter)
    end
  end

  sig { params(newsletter: Newsletter).returns(String) }
  def scoped_newsletter_url(newsletter)
    if request.subdomain.present?
      domain_newsletter_url(newsletter)
    else
      account_newsletter_url(newsletter.account, newsletter)
    end
  end
end
