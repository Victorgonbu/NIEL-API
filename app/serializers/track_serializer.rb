class TrackSerializer
  include JSONAPI::Serializer
  include TrackHelper
  set_key_transform :camel_lower
  attributes :name, :bpm, :buyable
  has_many :genres
  

  attribute :own do |track, params|
    if params[:user_purchases]
      params[:user_purchases].any? do |purchase|
        purchase[:orderable] == track.id
      end
    else
      false
    end
  end

  

  has_many :purchases, serializer: TrackSerializer

  attribute :pcm do |track|
    JSON.parse(track.pcm)
  end

  attribute :related_tracks do |track, params|
    related_tracks(track) unless params[:no_related]
  end

  attribute :created_at do |track|
    track.created_at.strftime('%F')
  end
  
  attribute :image_file do |track, params|
    if params[:admin]
      {
        blob_id: track.image_file.signed_id,
        url: image_url(track)
      }
    else
      {
        url: image_url(track)
      }
    end
  end

  attribute :mp3_file do |track, params|
   
    if params[:admin]
      {
        blob_id: track.mp3_file.signed_id,
        url: mp3_url(track)
      }
    else
      {
        url: mp3_url(track)
      }
    end
  end

  # license higher than 1
  attribute :wav_file do |track, params|
    if params[:admin]
      {
        blob_id: track.wav_file.signed_id,
        url: wav_url(track)
      }
    elsif params[:user_purchases]
      track_user_purchases = params[:user_purchases].find_all do |purchase|
        purchase[:orderable] == track.id
      end
      if track_user_purchases.length.positive?
        higher_purchase = track_user_purchases.max { |a, b| a[:license] <=> b[:license] }
        if higher_purchase[:license] >= 2
          {
            url: wav_url(track)
          }
        end
      end
    end

  end
  # license higher than 2
  attribute :zip_file do |track, params|
    if params[:admin]
      {
        blob_id: track.zip_file.signed_id,
        url: zip_url(track)
      }
    elsif params[:user_purchases]
      track_user_purchases = params[:user_purchases].find_all do |purchase|
        purchase[:orderable] == track.id
      end
      if track_user_purchases.length.positive?
        higher_purchase = track_user_purchases.max { |a, b| a[:license] <=> b[:license] }
        if higher_purchase[:license] >= 3
          {
            url: zip_url(track)
          }
        end
      end
    end
  end
end
