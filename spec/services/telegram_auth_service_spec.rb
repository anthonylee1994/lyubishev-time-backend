# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TelegramAuthService, type: :service do
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
      last_name: 'hihi',
      username: 'internal_server_error',
      photo_url: 'https://t.me/i/userpic/320/0HsMKYOWlgnBA2Httlfb3NBMp50KmdI4fD8tsNZu2js.jpg',
      auth_date: 1_704_103_504,
      hash: 'd568e2e083d24d9839f0934d981c9d6932f288ebfdc043bf9c3f4b73945baa3c'
    }
  end

  example 'check correct token' do
    expect(TelegramAuthService.verify!(correct_auth_data)).to be_truthy
  end

  example 'check token' do
    expect do
      TelegramAuthService.verify!(incorrect_auth_data)
    end.to raise_error(Exceptions::InvalidToken)
  end
end
