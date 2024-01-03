class TimeEventTagsController < ApplicationController
  before_action :set_time_event_tag, only: %i[update]

  def index
    empty_name_items = @current_user.time_event_tags.where.not(name: '').order(:order)
    has_name_items = @current_user.time_event_tags.where(name: '').order(:order)
    items = empty_name_items + has_name_items

    render json: items
  end

  def create
    @time_event_tag = @current_user.time_event_tags.new(time_event_tag_params)

    if @time_event_tag.save
      render json: @time_event_tag, status: :created
    else
      render json: @time_event_tag.errors, status: :unprocessable_entity
    end
  end

  def update
    if @time_event_tag.update(time_event_tag_params)
      render json: @time_event_tag
    else
      render json: @time_event_tag.errors, status: :unprocessable_entity
    end
  end

  def set_time_event_tag
    @time_event_tag = @current_user.time_event_tags.find(params[:id])
  end

  def time_event_tag_params
    params.permit(:name, :color_id, :order)
  end
end
