class TrackInteractor::Create
    include Interactor

    delegate :track_params, to: :context

    def call
        context.output = create_track
        context.status = :created
    end

    private

    def create_track
        track = Track.new(track_params)
        return track if track.save
        
        context.fail!(errors: track.errors.full_messages, error_status: :unprocessable_entity)
    end
end