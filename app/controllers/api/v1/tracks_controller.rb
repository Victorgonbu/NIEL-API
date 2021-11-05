class Api::V1::TracksController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!, only: [:create, :update]

  def create
    @track = Track.new(track_params.except(:genres))
    genres = track_params[:genres]
    
    if @track.save && !genres.empty?
      genres.each {|genre| @track.genre_tracks.create(genre_id: genre["id"])}
      render json: TrackSerializer.new(@track, options).serializable_hash.to_json, status: 200

    else
      render json: {errors: @track.errors.full_messages}, status: 422
    end
  end

  def show
    @track = Track.find(params[:id])
    if @track.present?
      render json: TrackSerializer.new(@track, options).serializable_hash.to_json, status: 200
    else
      render json: {errors: ['Not found']}, status: 404
    end
  end

  def index 
    genres = params[:genres].try(:split, ',')

    @tracks = genres ? Track.by_genre(genres) : Track.all_tracks
    
    @tracks = pagy(@tracks)
    #.last is needed due to pagy return
    @tracks.last

    render json: 
    TrackSerializer.new(@tracks.last, options({related_tracks: false})).serializable_hash.to_json, status: 200
  rescue ActiveRecord::RecordNotFound
    render json: {message: 'genre not found'}, status: 404
  rescue Pagy::OverflowError
    render json: {errors: ['Not found']}, status: 404
  end
  
  private

  def options(opt = {related_tracks: true})
    {
      params: {
        related_tracks: opt[:related_tracks],
        user_purchases: user_purchases, 
        admin: current_user ? current_user.admin : false 
      }
    }
  end

  def user_purchases
    return [] unless current_user
    
    current_user.purchases.includes(:license).map do |purchase|
      { orderable: purchase.orderable_id, license: purchase.license.number }
    end
                      
  end

  def track_params
    params.require(:track).permit(:name, :bpm, :pcm, :buyable, :mp3_file, :zip_file, :wav_file, :image_file, 
      genres: [:id])
  end
  def authenticate_user!
    render json: {errors: ['No valid user']}, status: 400 unless current_user && current_user.admin
  end
end