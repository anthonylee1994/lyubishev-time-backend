require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) do
    User.create!(
      telegram_id: '234392020',
      first_name: '窮三代IT狗',
      username: 'internal_server_error',
      photo_url: 'https://t.me/i/userpic/320/0HsMKYOWlgnBA2Httlfb3NBMp50KmdI4fD8tsNZu2js.jpg',
      auth_date: 1_704_103_504
    )
  end

  let(:authorization) do
    "Bearer #{user.token}"
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
    end

    example 'fail case' do
      get '/me', as: :json, headers: { Authorization: 'Bearer 1234' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
