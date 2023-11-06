# typed: false
# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_new_post, only: %i[new create]

  def index
    authorize! and redirect_to current_account
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

  sig { returns Post }
  def post
    @post ||= authorized(Post.all).kept.friendly.find(id)
  end

  sig { returns Update::RelationType }
  def updates
    @updates ||= current_account.updates
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
          .merge(post:, user: current_user, account: current_account)
  end

  sig { returns T::Locals }
  def form
    {
      locals: {
        post: post.decorate,
        updates: updates.decorate,
        newsletters: current_account.newsletters
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
