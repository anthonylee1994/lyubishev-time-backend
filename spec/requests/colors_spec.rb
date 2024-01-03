require 'rails_helper'

RSpec.describe 'Colors', type: :request do
  describe 'GET /index' do
    example 'list colors' do
      get '/colors'
      expect(response).to have_http_status(:success)
      expect(response.body).to eq(Color.all.to_json)
    end
  end
end
