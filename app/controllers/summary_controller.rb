# frozen_string_literal: true

class SummaryController < ApplicationController
  def index
    params[:day] = 1 unless params[:day].present?

    @time_events = if params[:day] == 1
                     @current_user.time_events.where(date: Time.zone.today)
                   else
                     @current_user.time_events.where(date: params[:day].to_i.days.ago..Time.zone.now)
                   end

    render json: @time_events.group(:tag_id).sum(:minute)
  end
end
