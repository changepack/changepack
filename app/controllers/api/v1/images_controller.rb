# typed: false
# frozen_string_literal: true

module API
  module V1
    class ImagesController < API::ApplicationController
      def create
        image = API::Image.new
        image.file.attach(file)
        image.save!

        render json: { url: url_for(image.file) }, status: :created
      end

      private

      def file
        params.require(:file)
      end
    end
  end
end
