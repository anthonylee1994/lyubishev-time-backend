class TimeEventsController < ApplicationController
  before_action :set_time_event, only: %i[update]

  def index
    if params[:date].blank?
      render json: { error: 'date is required' }, status: :unprocessable_entity
      return
    end

    render json: list_all
  end

  def create
    @time_event = @current_user.time_events.new(time_event_params)

    if @time_event.save
      render json: @time_event, status: :created
    else
      render json: @time_event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @time_event.update(time_event_params)
      render json: @time_event
    else
      render json: @time_event.errors, status: :unprocessable_entity
    end
  end

  def reorder
    if params[:date].blank?
      render json: { error: 'date is required' }, status: :unprocessable_entity
      return
    end

    ActiveRecord::Base.transaction do
      params[:ids].each_with_index do |time_event_id, index|
        @current_user.time_events.find(time_event_id).update!(order: index)
      end
    end

    render json: list_all
  end

  def destroy
    @time_event = @current_user.time_events.find(params[:id])
    @time_event.destroy
  end

  private

  def time_event_params
    params.permit(:name, :tag_id, :order, :date, :minute)
  end

  def set_time_event
    @time_event = @current_user.time_events.find(params[:id])
  end

  def list_all
    @current_user.time_events.where(date: params[:date]).includes(:tag).order(:order)
  end
end
