# typed: false
# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_new_post, only: %i[new create]

  def index
    authorize! and render locals: { posts: }
  end

  def show
    authorize! post and render item
  end

  def new
    authorize! and render form
  end

  def edit
    authorize! post and render form
  end

  def confirm_destroy
    authorize! post, to: :destroy? and render item
  end

  def create
    authorize!

    Publication.new(permitted).create

    if post.valid?
      redirect_to post
    else
      render :new, form
    end
  end

  def update
    authorize! post

    Publication.new(permitted).update

    if post.valid?
      redirect_to post
    else
      render :edit, form
    end
  end

  def destroy
    authorize! post

    post.discard
    redirect_to posts_url
  end

  private

  sig { returns Post::RelationType }
  def posts
    @posts ||= authorized(Post.all)
               .kept
               .recent
               .with_rich_text_content_and_embeds
               .includes(:user)
  end

  sig { returns Post }
  def post
    @post ||= authorized(Post.all).kept.friendly.find(id)
  end

  sig { returns Update::RelationType }
  def updates
    @updates ||= Current.account
                        .updates
                        .options(post)
                        .includes(:post, commit: :repository, issue: :team)
                        .limit(100)
                        .kept
  end

  sig { returns Post }
  def set_new_post
    @post = Post.new
  end

  sig { returns T::Params }
  def permitted
    params.require(:post)
          .then { |permitted| authorized(permitted) }
          .merge(post:, user: Current.user, account: Current.account)
  end

  sig { returns T::Locals }
  def form
    {
      locals: {
        post: post.decorate,
        updates: updates.decorate,
        newsletters: Current.account.newsletters
      }
    }
  end

  sig { returns T::Locals }
  def item
    {
      locals: { post: }
    }
  end
end
