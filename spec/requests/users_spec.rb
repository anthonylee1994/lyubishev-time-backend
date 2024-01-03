require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { User.first }

  let(:authorization) { "Bearer #{user.token}" }

  before(:each) do
    load "#{Rails.root}/db/seeds/user.seeds.rb"
  end

  describe 'user' do
    example 'success case' do
      get '/me', as: :json, headers: { Authorization: authorization }
      expect(response).to have_http_status(:success)

      json_body = JSON.parse(response.body)
      expect(json_body['telegram_id']).to eq(user.telegram_id)
      expect(json_body['first_name']).to eq(user.first_name)
      expect(json_body['username']).to eq(user.username)
      expect(json_body['photo_url']).to eq(user.photo_url)
      expect(json_body['auth_date']).to eq(user.auth_date)
      expect(json_body['token']).not_to be_present
    end

    example 'fail case' do
      get '/me', as: :json, headers: { Authorization: 'Bearer 1234' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
