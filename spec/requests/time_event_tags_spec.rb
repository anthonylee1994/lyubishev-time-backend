require 'rails_helper'

RSpec.describe 'TimeEventTags', type: :request do
  let(:user) { User.first }

  let(:first_time_event_tag) do
    user.time_event_tags.create!(color: Color.first, name: '娛樂')
  end

  before(:each) do
    load "#{Rails.root}/db/seeds/user.seeds.rb"
    load "#{Rails.root}/db/seeds/color.seeds.rb"
  end

  describe 'time event tags' do
    example 'list' do
      first_time_event_tag

      get '/time_event_tags', as: :json, headers: { Authorization: "Bearer #{user.token}" }
      expect(response).to have_http_status(:success)

      json_body = JSON.parse(response.body)
      expect(json_body.pluck('color').pluck('hexcode')).to eq(%w[#E53E3E])
    end

    example 'update first time event tag', focus: true do
      put "/time_event_tags/#{first_time_event_tag.id}", as: :json,
                                                         headers: { Authorization: "Bearer #{user.token}" },
                                                         params: { name: '運動', color: Color.first }
      expect(response).to have_http_status(:success)

      json_body = JSON.parse(response.body)

      expect(json_body['name']).to eq('運動')

      put "/time_event_tags/#{first_time_event_tag.id}", as: :json,
                                                         headers: { Authorization: "Bearer #{user.token}" },
                                                         params: { name: nil }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
