class TrackInteractor::Index
    include Interactor
    include Pagy::Backend

    delegate :params, to: :context

    def call
        context.output = get_track_index
    end

    private

    def get_track_index
        genres = params[:genres].try(:split, ',')
        context.pagy, tracks = pagy(
            genres ? Track.by_genre(genres) : Track.all_tracks,
            items: params[:limit]
        )

        tracks
      rescue ActiveRecord::RecordNotFound
        context.fail!(errors: ['Genre not found'], error_status: :not_found)
      rescue Pagy::OverflowError
        context.fail!(errors: ['Not found'], error_status: :not_found)
    end
end