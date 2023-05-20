# typed: false
# frozen_string_literal: true

require 'rails_helper'

module API
  module V1
    describe PostsController do
      let(:account) { create(:account) }
      let(:params) { { title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph } }
      let(:headers) { { 'Authorization' => "Bearer #{account.api_keys.pick(:token)}" } }

      it 'saves a post' do
        expect { post api_v1_posts_path, params:, headers: }.to change(Post, :count).by(1)
      end
    end
  end
end
