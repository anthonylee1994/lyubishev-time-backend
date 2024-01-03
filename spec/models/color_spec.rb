require 'rails_helper'

RSpec.describe Color, type: :model do
  example 'create color' do
    color = Color.create!(name: '灰色', hexcode: '#718096')
    expect(color.hexcode).to eq('#718096')
    expect { Color.create!(name: '色', hexcode: '#718096') }.to raise_error(ActiveRecord::RecordNotUnique)
  end
end
