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
        end
      end

      def create
        publication = Publication.new(
          post: Post.new,
          account: current_bearer,
          **validation_result.to_h
        ).tap(&:create)

        render json: publication.post, status: :created
      end
    end
  end
end
