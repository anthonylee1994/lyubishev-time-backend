# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JwtService, type: :service do
  let(:token) { 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.TTAIAN-6SDnRE8vGJpNPrlbiIp4Sm_PVvW7GXhMI_qs' }

  example 'encode' do
    expect(JwtService.encode(user_id: 1)).to eq token
  end

  example 'decode' do
    expect(JwtService.decode(token)).to eq(user_id: 1)
  end
end
