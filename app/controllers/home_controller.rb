# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_request
  def index
    render json: { name: 'Lyubishchev', version: '0.0.1' }
  end
end
