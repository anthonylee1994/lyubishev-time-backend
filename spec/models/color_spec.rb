require 'rails_helper'

RSpec.describe Color, type: :model do
  example 'create color' do
    color = Color.first
    expect(color.hexcode).to eq('#E53E3E')
  end
end
