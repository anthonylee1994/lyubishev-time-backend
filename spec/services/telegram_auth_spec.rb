require 'rails_helper'

RSpec.describe TelegramAuthService, type: :service do
  let(:auth_data) do
    {
      id: 234392020,
      first_name: "窮三代IT狗",
      username: "internal_server_error",
      photo_url: "https://t.me/i/userpic/320/0HsMKYOWlgnBA2Httlfb3NBMp50KmdI4fD8tsNZu2js.jpg",
      auth_date: 1704103504,
      hash: "d568e2e083d24d9839f0934d981c9d6932f288ebfdc043bf9c3f4b73945baa3c"
    }
  end

  example "check token" do
    expect(TelegramAuthService.verify!(auth_data)).to be_truthy
  end
end
