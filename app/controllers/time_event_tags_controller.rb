class TimeEventTagsController < ApplicationController
  before_action :set_time_event_tag, only: %i[update]

  def index
    render json: @current_user.time_event_tags.load_children_with_order
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

  def reorder
    ActiveRecord::Base.transaction do
      params[:ids].each_with_index do |time_event_tag_id, index|
        @current_user.time_event_tags.find(time_event_tag_id).update!(order: index)
      end
    end

    head :ok
  end

  def destroy
    @time_event_tag = @current_user.time_event_tags.find(params[:id])
    @time_event_tag.destroy
  end

  private

  def time_event_tag_params
    params.permit(:name, :color_id, :order)
  end

  def set_time_event_tag
    @time_event_tag = @current_user.time_event_tags.find(params[:id])
  end
end
