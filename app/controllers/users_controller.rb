class UsersController < ApplicationController
  def me
    render json: @current_user
  end

  def update
    if @current_user.update(user_params)
      render json: @current_user
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:time_event_tags_attributes)
  end
end
