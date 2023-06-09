# typed: false
# frozen_string_literal: true

module API
  module V1
    class ImagesController < API::ApplicationController
      def create
        image = API::Image.create

        if image.file.attach params[:file]
          render json: { url: url_for(image.file) }, status: :created
        else
          render status: :unprocessable_entity
        end
      end
    end
  end
end
