# typed: false
# frozen_string_literal: true

require 'rails_helper'

module API
  module V1
    describe ImagesController do
      let(:account) { create(:account) }
      let(:image_path) { Rails.root.join('spec/files/placeholder.png') }
      let(:headers) { { 'Authorization' => "Bearer #{account.api_keys.pick(:token)}" } }

      it 'uploads an image' do
        params = { file: Rack::Test::UploadedFile.new(image_path) }

        expect { post api_v1_images_path, params:, headers: }.to change(API::Image, :count).by(1)
      end
    end
  end
end
