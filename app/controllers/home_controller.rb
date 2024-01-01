class HomeController < ApplicationController
  def index
    render json: { name: "Lyubishchev", version: "0.0.1" }
  end
end
