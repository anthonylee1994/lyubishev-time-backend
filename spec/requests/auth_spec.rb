require 'rails_helper'

RSpec.describe 'Auths', type: :request do
  let(:correct_auth_data) do
    {
      id: '234392020',
      first_name: '窮三代IT狗',
      username: 'internal_server_error',
      photo_url: 'https://t.me/i/userpic/320/0HsMKYOWlgnBA2Httlfb3NBMp50KmdI4fD8tsNZu2js.jpg',
      auth_date: 1_704_103_504,
      hash: 'd568e2e083d24d9839f0934d981c9d6932f288ebfdc043bf9c3f4b73945baa3c'
    }
  end

  let(:incorrect_auth_data) do
    {
      id: '123392020',
      first_name: '窮三代IT狗',
      username: 'internal_server_error',
      photo_url: 'https://t.me/i/userpic/320/0HsMKYOWlgnBA2Httlfb3NBMp50KmdI4fD8tsNZu2js.jpg',
      auth_date: 1_704_103_504,
      hash: 'd568e2e083d24d9839f0934d981c9d6932f288ebfdc043bf9c3f4b73945baa3c'
    }
  end

  describe 'login' do
    example 'success case' do
      post '/auth/login', params: correct_auth_data
      expect(response).to have_http_status(:success)

      json_body = JSON.parse(response.body)
      expect(json_body['user']['telegram_id']).to eq(correct_auth_data[:id])
      expect(json_body['user']['first_name']).to eq(correct_auth_data[:first_name])
      expect(json_body['user']['username']).to eq(correct_auth_data[:username])
      expect(json_body['user']['photo_url']).to eq(correct_auth_data[:photo_url])
      expect(json_body['user']['auth_date']).to eq(correct_auth_data[:auth_date])
      expect(json_body['token']).to be_present
    end

    example 'fail case' do
      post '/auth/login', params: incorrect_auth_data
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
