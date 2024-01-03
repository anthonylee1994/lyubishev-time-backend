require 'rails_helper'

RSpec.describe TimeEvent, type: :model do
  let(:user) { User.first }
  let(:time_event) do
    user.time_events.create!(name: 'test', date: Time.now, minute: 10, tag: user.time_event_tags.first)
  end

  before(:each) do
    load "#{Rails.root}/db/seeds/user.seeds.rb"
  end

  example 'create time event' do
    expect(time_event).to be_valid
    expect(time_event.name).to eq('test')
    expect(time_event.tag).to eq(user.time_event_tags.first)
  end

  example 'delete tag' do
    time_event.tag.destroy!
    expect { time_event.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
