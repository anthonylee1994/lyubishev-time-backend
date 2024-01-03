class AuthController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login]

  def login
    begin
      TelegramAuthService.verify!(auth_params)
    rescue Exceptions::InvalidToken => e
      head :unauthorized
      return
    end
    @current_user = User.from_auth_data(auth_params)
    render json: @current_user, status: :ok, show_token: true
  end

  private

  def auth_params
    params.permit(:auth_date, :first_name, :id, :last_name, :photo_url, :username, :hash).to_hash.symbolize_keys
  end
end
