class Api::V1::GenresController < ApplicationController
  skip_before_action :authenticate_token!
  def index
    @genres = Genre.all
    render json: GenreSerializer.new(@genres).serializable_hash.to_json, status: 200
  end

  def show
    @genre = Genre.find_by_slug(params[:slug])
    if @genre.present?
      render json: GenreSerializer.new(@genre, options).serializable_hash.to_json, status: 200
    end
  end

  private
  def options
    {include: [:tracks]}
  end
end