require 'rails_helper'

RSpec.describe 'TimeEvents', type: :request do
  let(:user) { User.first }

  before(:each) do
    load "#{Rails.root}/db/seeds/user.seeds.rb"
  end

  describe 'GET /index' do
    example 'list time events' do
      user.time_events.create!(name: 'test', tag: user.time_event_tags.first, date: '2024-01-01', minute: 60)

      get '/time_events?date=2024-01-01', as: :json,
                                          headers: { Authorization: "Bearer #{user.token}" }
      json_body = JSON.parse(response.body)
      expect(json_body.pluck('name')).to eq(['test'])
    end

    example 'create time event' do
      post '/time_events', as: :json,
                           headers: { Authorization: "Bearer #{user.token}" },
                           params: { name: 'test', tag_id: user.time_event_tags.first.id, date: '2024-01-01', minute: 60 }
      json_body = JSON.parse(response.body)

      expect(json_body['name']).to eq('test')
    end

    example 'update time event' do
      time_event = user.time_events.create!(name: 'test', tag: user.time_event_tags.first, date: '2024-01-01',
                                            minute: 60)

      put "/time_events/#{time_event.id}", as: :json,
                                           headers: { Authorization: "Bearer #{user.token}" },
                                           params: { name: 'test2' }
      json_body = JSON.parse(response.body)

      expect(json_body['name']).to eq('test2')
    end

    example 'reorder time events' do
      time_event1 = user.time_events.create!(name: 'test', tag: user.time_event_tags.first, date: '2024-01-01',
                                             minute: 60)
      time_event2 = user.time_events.create!(name: 'test', tag: user.time_event_tags.first, date: '2024-01-01',
                                             minute: 60)

      put '/time_events/reorder', as: :json,
                                  headers: { Authorization: "Bearer #{user.token}" },
                                  params: { ids: [time_event2.id, time_event1.id], date: '2024-01-01' }

      expect(response).to have_http_status(:success)
    end

    example 'destroy time event' do
      time_event = user.time_events.create!(name: 'test', tag: user.time_event_tags.first, date: '2024-01-01',
                                            minute: 60)

      delete "/time_events/#{time_event.id}", as: :json,
                                              headers: { Authorization: "Bearer #{user.token}" }
      expect(response.status).to eq(204)
    end
  end
end
