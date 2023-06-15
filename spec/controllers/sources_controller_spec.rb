# typed: false
# frozen_string_literal: true

require 'rails_helper'
RSpec.describe SourcesController do
  include Devise::Test::ControllerHelpers
RSpec.describe SourcesController do
  describe 'GET #index' do
    it 'authorizes the user' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'paginates the sources' do
      10.times { Source.create }
      get :index, params: { page: 2 }
      expect(assigns(:sources).length).to eq(5)
    end

    it 'renders the sources' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
