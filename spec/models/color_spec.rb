require 'rails_helper'

RSpec.describe Color, type: :model do
  example 'create color' do
    color = Color.create!(name: '紅色', hexcode: '#E53E3E')
    expect(color.hexcode).to eq('#E53E3E')
  end
end
