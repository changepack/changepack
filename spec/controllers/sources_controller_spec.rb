# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SourcesController do
  include Devise::Test::ControllerHelpers

  before { sign_in create(:user) }

  describe 'GET #index' do
    it 'authorizes the user' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
