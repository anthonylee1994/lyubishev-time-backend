class ColorsController < ApplicationController
  skip_before_action :authenticate_request
  def index
    render json: Color.all
  end
end
