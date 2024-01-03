# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.first }

  example 'create user with time event tag' do
    expect(user).to be_valid
    expect(user.time_event_tags.count).to eq(4)
  end
end
