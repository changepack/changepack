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

  sig { params(changelog: Changelog).returns(String) }
  def scoped_changelog_path(changelog)
    if request.subdomain.present?
      domain_changelog_path(changelog)
    else
      account_changelog_path(changelog.account, changelog)
    end
  end

  sig { params(changelog: Changelog).returns(String) }
  def scoped_changelog_url(changelog)
    if request.subdomain.present?
      domain_changelog_url(changelog)
    else
      account_changelog_url(changelog.account, changelog)
    end
  end
end
