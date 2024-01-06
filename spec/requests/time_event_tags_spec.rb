require 'rails_helper'

RSpec.describe 'TimeEventTags', type: :request do
  let(:user) { User.first }
  let(:first_time_event_tag) { user.time_event_tags.first }

  before(:each) do
    load "#{Rails.root}/db/seeds/user.seeds.rb"
  end

  describe 'time event tags' do
    example 'list' do
      first_time_event_tag

      get '/time_event_tags', as: :json, headers: { Authorization: "Bearer #{user.token}" }
      expect(response).to have_http_status(:success)

      json_body = JSON.parse(response.body)
      expect(json_body.pluck('color_id')).to eq(user.time_event_tags.pluck('color_id'))
    end

    example 'create time event tag' do
      post '/time_event_tags', as: :json,
                               headers: { Authorization: "Bearer #{user.token}" },
                               params: { name: '運動', color_id: Color.first.id }

      expect(response).to have_http_status(:success)

      json_body = JSON.parse(response.body)

      expect(json_body['name']).to eq('運動')
    end

    example 'update first time event tag' do
      put "/time_event_tags/#{first_time_event_tag.id}", as: :json,
                                                         headers: { Authorization: "Bearer #{user.token}" },
                                                         params: { name: '運動', color_id: Color.first.id }
      expect(response).to have_http_status(:success)

      json_body = JSON.parse(response.body)

      expect(json_body['name']).to eq('運動')

      put "/time_event_tags/#{first_time_event_tag.id}", as: :json,
                                                         headers: { Authorization: "Bearer #{user.token}" },
                                                         params: { name: nil }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    example 'delete first time event tag' do
      delete "/time_event_tags/#{first_time_event_tag.id}", as: :json,
                                                            headers: { Authorization: "Bearer #{user.token}" }

      expect(response).to have_http_status(:success)
    end

    example 'reorder time event tags' do
      ids = user.time_event_tags.pluck(:id)

      put '/time_event_tags/reorder', as: :json,
                                      headers: { Authorization: "Bearer #{user.token}" },
                                      params: { ids: ids.reverse }

      expect(response).to have_http_status(:success)
    end
  end
end
