require 'rails_helper'

RSpec.describe TimeEventTag, type: :model do
  let(:user) { User.first }
  let(:color) { Color.first }

  before(:each) do
    load "#{Rails.root}/db/seeds/user.seeds.rb"
    load "#{Rails.root}/db/seeds/color.seeds.rb"
  end

  example 'create user with default time event tags' do
    time_event_tag = user.time_event_tags.create!(color:, name: '娛樂')
    expect(time_event_tag).to be_valid
    expect(time_event_tag.name).to eq('娛樂')
    expect(time_event_tag.color).to eq(color)
  end
end
