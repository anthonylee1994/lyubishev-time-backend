# frozen_string_literal: true

class SummaryController < ApplicationController
  def index
    params[:day] = 1 unless params[:day].present?

    render json: @current_user.time_events.where(date: params[:day].to_i.days.ago..Time.zone.now).group(:tag_id).sum(:minute)
  end
end
