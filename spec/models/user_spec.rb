require 'rails_helper'

RSpec.describe User, type: :model do
  example "create user 窮三代IT狗" do
    user = User.create!(
      telegram_id: 234392020,
      first_name: "窮三代IT狗",
      username: "internal_server_error",
      photo_url: "https://t.me/i/userpic/320/0HsMKYOWlgnBA2Httlfb3NBMp50KmdI4fD8tsNZu2js.jpg",
      auth_date: 1704103504
    )

    expect(user).to be_valid
  end
end
