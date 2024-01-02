# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_request

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      decoded = JwtService.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue Exceptions::InvalidToken
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end
