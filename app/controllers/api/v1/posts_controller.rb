# typed: false
# frozen_string_literal: true

module API
  module V1
    class PostsController < API::ApplicationController
      def create
        publication = Publication.new(
          account: current_bearer,
          post: Post.new,
          **params.permit(:title, :content, :published)
        ).tap(&:create)

        render json: publication.post, status: :created
      end
    end
  end
end
