# frozen_string_literal: true

class SummaryController < ApplicationController
  def index
    render json: { daily:, seven_days:, thirty_days: }
  end

  private

  def daily
    @current_user.time_events.where(date: 1.days.ago..Time.zone.now).group(:tag_id).sum(:minute)
  end

  def seven_days
    @current_user.time_events.where(date: 7.days.ago..Time.zone.now).group(:tag_id).sum(:minute)
  end

  def thirty_days
    @current_user.time_events.where(date: 30.days.ago..Time.zone.now).group(:tag_id).sum(:minute)
  end
end
