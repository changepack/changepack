# typed: false
# frozen_string_literal: true

module API
  module V1
    class PostsController < API::ApplicationController
      self.schema = Class.new(Dry::Validation::Contract) do
        params do
          required(:content).filled(:string)

          optional(:title).filled(:string)
          optional(:published).filled(:bool)
          optional(:published_at).filled(:time)
        end
      end

      def create
        publication = Publication.new(
          post: Post.new,
          account: current_bearer,
          **validation_result.to_h.except(:published_at)
        ).tap(&:create)

        publication.post.update!(published_at:) if published_at.present?

        render json: publication.post, status: :created
      end

      private

      def published_at
        validation_result[:published_at]
      end
    end
  end
end
