class Api::V1::TracksController < ApplicationController
  
  #before_action :authenticate_admin!, only: [:create, :update]

  def create
    initialize_render_concern(create_track_interactor, :output, options)

    render_result_serializer
  end

  def show
    initialize_render_concern(show_track_interactor, :output, options)

    render_result_serializer
  end

  def index 
    initialize_render_concern(index_track_interactor, :output, options({related_tracks: false}))

    render_result_serializer(index: true)
  end
  
  private
  
  def create_track_interactor
    TrackInteractor::Create.call(track_params: track_params)
  end

  def show_track_interactor
    TrackInteractor::Show.call(id: params[:id])
  end
  
  def index_track_interactor
    TrackInteractor::Index.call(params: params)
  end

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
      { orderable: purchase.orderable_id, license: purchase.license.uuid }
    end
                      
  end

  def track_params
    params.require(:track).permit(
      :name, 
      :bpm, 
      :pcm, 
      :buyable, 
      :mp3_file, 
      :zip_file, 
      :wav_file, 
      :image_file, 
      genre_tracks_attributes: [
        :genre_id
      ]
    )
  end
  
end