class Api::V1::IndexesController < ApplicationController
  def index
    @message = "NIELBEATS API"
    render :index, status: 200
  end  
end