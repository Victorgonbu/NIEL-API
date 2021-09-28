module TrackHelper
  extend ActiveSupport::Concern

  class_methods do
    def image_url(track)
      track.image_file.variant(resize_to_limit: [330, 330]).processed.url
      # Rails.application.routes.url_helpers.rails_blob_path(track.image_file, only_path: true)
    end

    def mp3_url(track)
      Rails.application.routes.url_helpers.rails_blob_path(track.mp3_file, only_path: true)
    end

    def wav_url(track)
      Rails.application.routes.url_helpers.rails_blob_path(track.wav_file, only_path: true)
    end

    def zip_url(track)
      Rails.application.routes.url_helpers.rails_blob_path(track.zip_file, only_path: true)
    end

    def related_tracks(track)
      genres_id = track.genres.map(&:id)
      related_track_list = Track.joins(:genres).where(genres: genres_id).where.not(id: track.id).distinct.take(10)
      TrackSerializer.new(related_track_list, { params: { no_related: true } })
    end
  end
end
