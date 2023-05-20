# typed: false
# frozen_string_literal: true

module API
  module V1
    class PostsController < API::ApplicationController
      def index
        @pagy, @posts = pagy_array(Post.none)
        render json: @posts
      end
    end
  end
end
