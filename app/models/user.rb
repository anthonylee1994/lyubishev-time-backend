# frozen_string_literal: true

class User < ApplicationRecord
  include ActiveModel::Serialization

  validates :telegram_id, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :username, presence: true, uniqueness: true, allow_nil: true

  def token
    JwtService.encode(user_id: id)
  end

  def self.from_auth_data(auth_params)
    @user = User.find_by(telegram_id: auth_params[:id])

    if @user
      @user.update!(auth_params.slice(:first_name, :last_name, :username, :photo_url, :auth_date))
    else
      @user = User.create!(auth_params.slice(:first_name, :last_name, :username, :photo_url,
                                             :auth_date).merge(telegram_id: auth_params[:id]))
    end

    @user
  end
end
