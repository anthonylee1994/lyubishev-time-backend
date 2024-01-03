# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.find_or_create_by!(
      telegram_id: '234392020',
      first_name: '窮三代IT狗',
      username: 'internal_server_error',
      photo_url: 'https://t.me/i/userpic/320/0HsMKYOWlgnBA2Httlfb3NBMp50KmdI4fD8tsNZu2js.jpg',
      auth_date: 1_704_103_504
    )
  end

  example 'create user with time event tag' do
    expect(user).to be_valid
    expect(user.time_event_tags.count).to eq(4)
  end
end
