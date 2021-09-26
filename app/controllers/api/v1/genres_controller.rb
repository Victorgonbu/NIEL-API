class Api::V1::GenresController < ApplicationController
  skip_before_action :authenticate_token!
  def index
    @genres = Genre.all
    render json: GenreSerializer.new(@genres).serializable_hash.to_json, status: 200
  end

  def show
    @genre = Genre.find(params[:id])
    if @genre.present?
      render json: GenreSerializer.new(@genre, options).serializable_hash.to_json, status: 200
    end
  end

  private
  def options
    {include: [:tracks]}
  end
end