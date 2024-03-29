# typed: false
# frozen_string_literal: true

module API
  module V1
    class PostsController < API::ApplicationController
      self.schema = Class.new(Dry::Validation::Contract) do
        params do
          required(:content).filled(:string)

          optional(:title).filled(:string)
          optional(:published_at).filled(:date)
        end
      end

      def create
        publication.create
        publication.post.update!(published_at:) if published_at.present?

        render json: publication.post, status: :created
      end

      private

      sig { returns Publication }
      def publication
        @publication ||= Publication.new(
          post: Post.new,
          account: current_bearer,
          **attributes
        )
      end

      sig { returns T::Hash[Symbol, T.untyped] }
      def attributes
        validation_result.to_h
                         .except(:published_at)
                         .merge(published: published_at.present?)
      end

      sig { returns T.nilable(T.any(T::Time, String)) }
      def published_at
        validation_result[:published_at]
      end
    end
  end
end
