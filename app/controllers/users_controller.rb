class UsersController < ApplicationController
  def me
    render json: @current_user, show_token: true
  end

  private

  def user_params
    params.permit(:time_event_tags_attributes)
  end
end
