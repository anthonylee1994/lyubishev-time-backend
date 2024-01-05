# frozen_string_literal: true

class User < ApplicationRecord
  has_many :time_event_tags, dependent: :destroy
  has_many :time_events, dependent: :destroy

  validates :telegram_id, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :username, presence: true, uniqueness: true, allow_nil: true

  after_create :create_default_time_event_tags

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

  def create_default_time_event_tags
    time_event_tags.create!([
                              { name: '緊急重要', color: Color.find_or_create_by(name: '紅色', hexcode: '#ffcdd2'),
                                order: 0 },
                              { name: '不緊急重要', color: Color.find_or_create_by(name: '黃色', hexcode: '#fff9c4'),
                                order: 1 },
                              { name: '緊急不重要', color: Color.find_or_create_by(name: '綠色', hexcode: '#c8e6c9'),
                                order: 2 },
                              { name: '不緊急不重要', color: Color.find_or_create_by(name: '藍色', hexcode: '#b3e5fc'),
                                order: 3 }
                            ])
  end
end
